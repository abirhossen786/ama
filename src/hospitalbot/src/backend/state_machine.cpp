#include <ros/ros.h>
#include <std_srvs/Empty.h>
#include <ros/package.h>
#include <std_msgs/String.h>
#include <hospitalbot/RobotState.h>
#include <hospitalbot/Communication.h>
#include <hospitalbot/Battery.h>
#include <move_base_msgs/MoveBaseAction.h>
#include <tf/transform_datatypes.h>
#include <actionlib/client/simple_action_client.h>
#include <random>
#include <fstream>
#include <queue>
#include <map>
#include <boost/msm/back/state_machine.hpp>
#include <boost/msm/front/state_machine_def.hpp>
#include <boost/msm/front/functor_row.hpp>

const int GOAL_PRIORITY_LIMIT = 100;
const int GOAL_ATTEMPT_LIMIT = 3;
const int QUEUED_GOAL_LIMIT = 50;
const int RANDOM_WALK_MESSAGE_COUNT = 5;
const std::string PACKAGE_NAME = "hospitalbot";
const std::string GOAL_FILES_RELATIVE_PATH = "/places";
const std::string SAFE_PLACE_FILENAME = "safe.txt";
const std::string GOALS_FILENAME = "goals.txt";
const std::string MAP_FRAME_ID = "map";
const std::string ROBOT_FRAME_ID = "base_footprint";
const std::string COMMUNICATION_TOPIC = "/hospitalbot/communication";
const std::string ROBOT_STATE_TOPIC = "/hospitalbot/robot_state";
const std::string ROBOT_BATTERY_TOPIC = "/hospitalbot/robot_battery";

enum RobotState {
    Lost,
    Standby,
    PendingFrontendClearance,
    Delivery,
    RequestProcessed,
    RequestInteraction,
    Homecoming,
    Charge
};

class Pose {
protected:
    std::string name;
    bool safe;
    move_base_msgs::MoveBaseGoal moveBaseGoalMessage;

public:
    Pose(std::string name, bool safe, std::string frame, double positionX, double positionY, double positionZ, double orientationX, double orientationY, double orientationZ, double orientationW) {
        this->name = name;
        this->safe = safe;
        this->moveBaseGoalMessage.target_pose.header.frame_id = frame;
        this->moveBaseGoalMessage.target_pose.pose.position.x = positionX;
        this->moveBaseGoalMessage.target_pose.pose.position.y = positionY;
        this->moveBaseGoalMessage.target_pose.pose.position.z = positionZ;
        this->moveBaseGoalMessage.target_pose.pose.orientation.x = orientationX;
        this->moveBaseGoalMessage.target_pose.pose.orientation.y = orientationY;
        this->moveBaseGoalMessage.target_pose.pose.orientation.z = orientationZ;
        this->moveBaseGoalMessage.target_pose.pose.orientation.w = orientationW;
    }

    Pose(const Pose& p) : Pose(
        p.name,
        p.safe,
        p.moveBaseGoalMessage.target_pose.header.frame_id,
        p.moveBaseGoalMessage.target_pose.pose.position.x,
        p.moveBaseGoalMessage.target_pose.pose.position.y,
        p.moveBaseGoalMessage.target_pose.pose.position.z,
        p.moveBaseGoalMessage.target_pose.pose.orientation.x,
        p.moveBaseGoalMessage.target_pose.pose.orientation.y,
        p.moveBaseGoalMessage.target_pose.pose.orientation.z,
        p.moveBaseGoalMessage.target_pose.pose.orientation.w
    ) {}
};

class Goal : public Pose {
private:
    int priority, attemptCount;
    std::string phoneNumber;

public:
    Goal(const Pose& p) : Pose(p) {
        this->priority = 0;
        this->attemptCount = 0;
        this->moveBaseGoalMessage.target_pose.header.stamp = ros::Time::now();
        this->phoneNumber = "";
    }

    Goal(const Pose& p, std::string phoneNumber) : Goal(p) {
        this->phoneNumber = phoneNumber;
    }

    bool operator<(const Goal& g) const {
        return this->priority < g.priority;
    }

    void decreasePriority() {
        if(this->priority < GOAL_PRIORITY_LIMIT) this->priority++;
    }

    void increaseAttemptCount() {
        this->attemptCount++;
    }

    int getAttemptCount() {
        return this->attemptCount;
    }

    std::string getName() {
        return this->name;
    }

    bool isSafe() {
        return this->safe;
    }

    move_base_msgs::MoveBaseGoal getMoveBaseGoalMessage() {
        return this->moveBaseGoalMessage;
    }

    std::string getPhoneNumber() {
        return this->phoneNumber;
    }
};

struct HospitalBotStateMachineFrontEnd : public boost::msm::front::state_machine_def<HospitalBotStateMachineFrontEnd> {
    //////////////// Events ////////////////
    struct QueueNotEmpty {};
    struct QueueEmpty {};
    struct GoalFailed {};
    struct GoalReached {};
    struct FrontendClearance{};
    struct RequestInteractionComplete{};
    struct CalibrationSucceeded {};
    struct CalibrationFailed {};
    struct MovedToSafePosition {};
    struct MoveToSafePositionFailed {};
    struct CalibrationSkipped {};
    struct Charging {};
    struct ChargingStopped {};
    struct ChargeNotEnough {};
    struct ChargeEnough {};

    //////////////// ROS variables ////////////////
    ros::Publisher robotStatePublisher;
    ros::Publisher communicationPublisher;
    ros::Subscriber communicationSubscriber;
    ros::Subscriber batterySubscriber;
    actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction> moveBaseClient;

    //////////////// FSM variables ////////////////
    std::map<std::string, Pose> goalPoseMap, safePoseMap;
    RobotState robotState;
    std::priority_queue<Goal> queue;
    std::queue<Goal> activeQueue;
    boost::msm::back::state_machine<HospitalBotStateMachineFrontEnd> &backEnd;
    bool calibrationFlag;
    bool clearCostmapsFlag;
    bool charging;
    bool chargeEnough;
    ros::ServiceClient clearCostmapsClient;

    HospitalBotStateMachineFrontEnd() : moveBaseClient("move_base", true), backEnd(static_cast<boost::msm::back::state_machine<HospitalBotStateMachineFrontEnd> &>(*this)) {
        ros::NodeHandle n("~");

        this->communicationSubscriber = n.subscribe(COMMUNICATION_TOPIC, 100,
            static_cast<boost::function<void(const hospitalbot::Communication::ConstPtr&)>>([&](const hospitalbot::Communication::ConstPtr& communication) {
                if(communication->source == "frontend" && communication->target == "backend" && communication->type == "interaction" && communication->status == "done") {
                    this->backEnd.process_event(RequestInteractionComplete());
                }
                else if(communication->source == "frontend" && communication->target == "backend" && communication->type == "clearance" && communication->status == "ok") {
                    this->backEnd.process_event(FrontendClearance());
                }
                else if(communication->source == "arduino" && communication->target == "backend" && communication->type == "sms") {
                    if(this->queue.size() < QUEUED_GOAL_LIMIT) {
                        if(goalPoseMap.find(communication->status) != goalPoseMap.end()) {
                            this->queue.push(Goal(goalPoseMap.find(communication->status)->second, communication->metadata));

                            ROS_INFO_STREAM("Goal queued. Total goals in queue: " << (this->queue.size()));
                            
                            if(this->robotState == RobotState::Standby || this->robotState == RobotState::Charge) {
                                this->backEnd.process_event(QueueNotEmpty());
                            }
                        }
                        else {
                            //? handle invalid destination else case
                            ROS_ERROR_STREAM("Invalid destination command!");
                        }
                    }
                    else {
                        //? handle queue full else case
                        ROS_ERROR_STREAM("Cannot process more goals because queue is full");
                    }
                }
                //? other cases
            })
        );

        this->batterySubscriber =  n.subscribe(ROBOT_BATTERY_TOPIC, 10,
            static_cast<boost::function<void(const hospitalbot::Battery::ConstPtr&)>>([&](const hospitalbot::Battery::ConstPtr& battery) {
                if(((double)battery->current_level) / ((double)battery->maximum_level) <= 0.15) {
                    this->chargeEnough = false;
                    this->backEnd.process_event(ChargeNotEnough());
                }
                else if(((double)battery->current_level) / ((double)battery->maximum_level) >= 0.15) {
                    this->chargeEnough = true;
                    this->backEnd.process_event(ChargeEnough());
                }
                
                if(battery->charging) {
                    this->charging = true;
                    this->backEnd.process_event(Charging());
                }
                else if(!battery->charging) {
                    this->charging = false;
                    this->backEnd.process_event(ChargingStopped());
                }
            })
        );

        this->robotStatePublisher = n.advertise<hospitalbot::RobotState>(ROBOT_STATE_TOPIC, 50, true);
        this->communicationPublisher = n.advertise<hospitalbot::Communication>(COMMUNICATION_TOPIC, 50, false);
        this->clearCostmapsClient = n.serviceClient<std_srvs::Empty>("/move_base/clear_costmaps");

        this->robotState = RobotState::Standby;
        this->charging = false;
        this->chargeEnough = true;

        this->buildPoseMaps();

        n.param<bool>("initial_calibration", this->calibrationFlag, false);
        n.param<bool>("clear_costmaps", this->clearCostmapsFlag, false);

        while(!this->moveBaseClient.waitForServer(ros::Duration(5.0))) {
            ROS_INFO("Goal Publisher: Waiting for the move_base action server to come up");
        }
    }
    
    //////////////// ROS functions ////////////////
    void publishRobotState(int activity, std::string message = "") {
        hospitalbot::RobotState robotStateMessage;
        robotStateMessage.id = 2;
        robotStateMessage.activity = activity;
        robotStateMessage.message = message;

        this->robotStatePublisher.publish(robotStateMessage);
    }

    void publishCommunication(std::string target, std::string type, std::string metadata, std::string status) {
        hospitalbot::Communication communicationMessage;
        communicationMessage.source = "backend";
        communicationMessage.target = target;
        communicationMessage.type = type;
        communicationMessage.metadata = metadata;
        communicationMessage.status = status;

        this->communicationPublisher.publish(communicationMessage);
    }

    void publishNotification(std::string phoneNumber, std::string type, std::string message = "") {
        ROS_INFO_STREAM("Notifying " << phoneNumber << " via " << type);
        if(type == "call") {
            this->publishCommunication("arduino", type, phoneNumber, "start");
        }
    }

    void calibrateRobot(boost::function<void()> successfulCallback, boost::function<void()> failedCallback) {
        std::random_device randomDevice;
        std::mt19937 generator(randomDevice());
        std::uniform_int_distribution<> distribution(0, 359);

        ROS_INFO_STREAM("Calibration started...");
        
        for(int i = 0; i < RANDOM_WALK_MESSAGE_COUNT; i++) {
            move_base_msgs::MoveBaseGoal randomWalkMessage;

            randomWalkMessage.target_pose.header.frame_id = ROBOT_FRAME_ID;
            randomWalkMessage.target_pose.pose.position.x = 0.5;
            randomWalkMessage.target_pose.pose.position.y = 0;
            randomWalkMessage.target_pose.pose.position.z = 0;
            randomWalkMessage.target_pose.pose.orientation = tf::createQuaternionMsgFromYaw(distribution(generator) * 0.017453278);

            this->moveBaseClient.sendGoal(randomWalkMessage);
            this->moveBaseClient.waitForResult(ros::Duration(10.0));
            ROS_INFO_STREAM("Calibration progress: " << (i + 1) << "/" << RANDOM_WALK_MESSAGE_COUNT);
        }

        ROS_INFO_STREAM("Calibration done!");

        successfulCallback();
    }

    //////////////// FSM actions ////////////////
    template<class Event, class FSM> void on_entry(Event const&, FSM& fsm) {}
    template<class Event, class FSM> void on_exit(Event const&, FSM&) {}

    void buildPoseMaps() {
        std::ifstream file;
        file.open(ros::package::getPath(PACKAGE_NAME) + GOAL_FILES_RELATIVE_PATH + "/" + SAFE_PLACE_FILENAME);
    
        std::string line;
        int lineCount = 0;
    
        while(getline(file, line)) {
            lineCount++;
            std::string name;
            double positionX, positionY, positionZ, orientationX, orientationY, orientationZ, orientationW;
            std::istringstream ss(line);
            ss >> name >> positionX >> positionY >> positionZ >> orientationX >> orientationY >> orientationZ >> orientationW;
            this->safePoseMap.insert(std::make_pair(name, Pose(name, true, MAP_FRAME_ID, positionX, positionY, positionZ, orientationX, orientationY, orientationZ, orientationW)));
        }
    
        file.close();
        ROS_INFO_STREAM("Parsed " << lineCount << " safe places");
    
        file.open(ros::package::getPath(PACKAGE_NAME) + GOAL_FILES_RELATIVE_PATH + "/" + GOALS_FILENAME);
        lineCount = 0;
    
        while(getline(file, line)) {
            lineCount++;
            std::string name;
            double positionX, positionY, positionZ, orientationX, orientationY, orientationZ, orientationW;
            std::istringstream ss(line);
            ss >> name >> positionX >> positionY >> positionZ >> orientationX >> orientationY >> orientationZ >> orientationW;
            this->goalPoseMap.insert(std::make_pair(name, Pose(name, false, MAP_FRAME_ID, positionX, positionY, positionZ, orientationX, orientationY, orientationZ, orientationW)));
        }
    
        file.close();
        ROS_INFO_STREAM("Parsed " << lineCount << " goals");
    }

    //////////////// FSM states ////////////////
    struct Lost : public boost::msm::front::state<> {
        template<class Event, class FSM> void on_entry(Event const&, FSM& fsm) {
            ROS_INFO_STREAM("Lost state");
            fsm.robotState = RobotState::Lost;

            fsm.publishRobotState(0);

            if(fsm.calibrationFlag) {
                fsm.calibrateRobot(
                    [&fsm]() {
                        fsm.backEnd.process_event(CalibrationSucceeded());
                    },
                    [&fsm]() {
                        fsm.backEnd.process_event(CalibrationFailed());
                    }
                );
            }
            else {
                fsm.backEnd.process_event(CalibrationSkipped());
            }
        }
    
        template<class Event, class FSM> void on_exit(Event const&, FSM&) {}
    };
    
    struct Homecoming : public boost::msm::front::state<> {
        template<class Event, class FSM> void on_entry(Event const&, FSM& fsm) {
            ROS_INFO_STREAM("Homecoming state");
            fsm.robotState = RobotState::Homecoming;

            fsm.publishRobotState(1, "Homecoming");
        }
    
        template<class Event, class FSM> void on_exit(Event const&, FSM&) {}
    };

    struct Standby : public boost::msm::front::state<> {
        template<class Event, class FSM> void on_entry(Event const&, FSM& fsm) {
            ROS_INFO_STREAM("Standby state");
            fsm.robotState = RobotState::Standby;

            fsm.publishRobotState(2);
            if(!fsm.calibrationFlag) {
                fsm.calibrationFlag = true;
            }

            if(fsm.charging || !fsm.chargeEnough) {
                fsm.backEnd.process_event(ChargeNotEnough());
            }
            else if(fsm.queue.size() && !fsm.charging && fsm.chargeEnough) {
                fsm.backEnd.process_event(QueueNotEmpty());
            }
        }
    
        template<class Event, class FSM> void on_exit(Event const&, FSM&) {}
    };

    struct PendingFrontendClearance : public boost::msm::front::state<> {
        template<class Event, class FSM> void on_entry(Event const&, FSM& fsm) {
            ROS_INFO_STREAM("Pending Frontend Clearance state");
            fsm.robotState = RobotState::PendingFrontendClearance;
        }
    
        template<class Event, class FSM> void on_exit(Event const&, FSM&) {}
    };

    struct Delivery : public boost::msm::front::state<> {
        template<class Event, class FSM> void on_entry(Event const&, FSM& fsm) {
            fsm.robotState = RobotState::Delivery;
            if(fsm.activeQueue.size()) {
                ROS_INFO_STREAM("Delivery started on goal: " << fsm.activeQueue.front().getName());
                fsm.publishRobotState(3, "Delivering to " + fsm.activeQueue.front().getName());
            }
            else {
                ROS_INFO_STREAM("Abandoned delivery");
                fsm.publishRobotState(3, "Abandoned delivery");
            }
        }
        template<class Event, class FSM> void on_exit(Event const&, FSM&) {}
    };

    struct RequestProcessed : public boost::msm::front::state<> {
        template<class Event, class FSM> void on_entry(Event const&, FSM& fsm) {
            ROS_INFO_STREAM("Request processed");
            fsm.robotState = RobotState::RequestProcessed;

            fsm.publishRobotState(5);

            if(fsm.queue.size()) fsm.backEnd.process_event(QueueNotEmpty());
            else fsm.backEnd.process_event(QueueEmpty());
        }
        template<class Event, class FSM> void on_exit(Event const&, FSM&) {}
    };

    struct RequestInteraction : public boost::msm::front::state<> {
        template<class Event, class FSM> void on_entry(Event const&, FSM& fsm) {
            ROS_INFO_STREAM("Request interaction");
            fsm.robotState = RobotState::RequestInteraction;

            fsm.publishRobotState(4);
            fsm.publishNotification(fsm.activeQueue.front().getPhoneNumber(), "call");
        }
        template<class Event, class FSM> void on_exit(Event const&, FSM&) {}
    };

    struct Charge : public boost::msm::front::state<> {
        template<class Event, class FSM> void on_entry(Event const&, FSM& fsm) {
            ROS_INFO_STREAM("Charge");
            fsm.robotState = RobotState::Charge;
        }
        template<class Event, class FSM> void on_exit(Event const&, FSM&) {}
    };

    typedef Lost initial_state; // The initial state of the SM

    //////////////// Transition actions ////////////////
    struct ProcessQueue {
        template<class Event, class FSM, class SourceState, class TargetState>
        void operator()(Event const&, FSM& fsm, SourceState&, TargetState& targetState) {
            if(!fsm.chargeEnough) {
                fsm.backEnd.process_event(ChargeNotEnough());
            }
            else {
                if(fsm.clearCostmapsFlag) {
                    std_srvs::Empty srv;
                    if(fsm.clearCostmapsClient.call(srv)) ROS_INFO("State Machine: Cleared costmaps!");
                }

                Goal goal = fsm.queue.top();
                fsm.queue.pop();
                fsm.activeQueue.push(goal);
                fsm.moveBaseClient.sendGoal(goal.getMoveBaseGoalMessage(),
                    [&fsm](const actionlib::SimpleClientGoalState& state, const move_base_msgs::MoveBaseResultConstPtr& result) {
                        ROS_INFO_STREAM("Goal finished in state: " << state.toString());
                        
                        fsm.activeQueue.front().increaseAttemptCount();
                
                        if(state == actionlib::SimpleClientGoalState::SUCCEEDED) {
                            fsm.backEnd.process_event(GoalReached());
                        }
                        else if(state == actionlib::SimpleClientGoalState::ABORTED) {
                            fsm.backEnd.process_event(GoalFailed());
                        }
                        //? handle other cases
                    },
                    actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction>::SimpleActiveCallback(),
                    actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction>::SimpleFeedbackCallback()
                );
            }
        }
    };

    struct MoveToSafePosition {
        template<class Event, class FSM, class SourceState, class TargetState>
        void operator()(Event const&, FSM& fsm, SourceState&, TargetState&) {
            fsm.moveBaseClient.sendGoal(Goal(fsm.safePoseMap.find("safe1")->second).getMoveBaseGoalMessage(),
                [&fsm](const actionlib::SimpleClientGoalState& state, const move_base_msgs::MoveBaseResultConstPtr& result) {
                    ROS_INFO_STREAM("Move to safe position finished in state: " << state.toString());
                    
                    if(state == actionlib::SimpleClientGoalState::SUCCEEDED) {
                        fsm.backEnd.process_event(MovedToSafePosition());
                    }
                    else if(state == actionlib::SimpleClientGoalState::ABORTED) {
                        fsm.backEnd.process_event(MoveToSafePositionFailed());
                    }
                    //? handle other cases
                },
                actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction>::SimpleActiveCallback(),
                actionlib::SimpleActionClient<move_base_msgs::MoveBaseAction>::SimpleFeedbackCallback()
            );
        }
    };

    struct EvaluateGoal {
        template<class Event, class FSM, class SourceState, class TargetState>
        void operator()(Event const& event, FSM& fsm, SourceState& sourceState, TargetState& targetState) {
            Goal activeGoal = fsm.activeQueue.front();
            fsm.activeQueue.pop();
            
            if(typeid(sourceState).name() == typeid(Delivery).name() && typeid(event).name() == typeid(GoalFailed).name()) {
                if(activeGoal.getAttemptCount() == GOAL_ATTEMPT_LIMIT) {
                    fsm.publishNotification(activeGoal.getPhoneNumber(), "sms", "Cannot reach " + activeGoal.getName() + " due to technical difficulties. Aborting.");
                }
                else {
                    activeGoal.decreasePriority();
                    fsm.queue.push(activeGoal);
                }
            }
            else if(typeid(sourceState).name() == typeid(RequestInteraction).name() && typeid(event).name() == typeid(RequestInteractionComplete).name()) {
                //? close drawer
            }
        }
    };

    struct NotifyControlRoom {
        template<class Event, class FSM, class SourceState, class TargetState>
        void operator()(Event const&, FSM&, SourceState&, TargetState&) {
            //? to be implemented
        }
    };

    struct DropAllRequests {
        template<class Event, class FSM, class SourceState, class TargetState>
        void operator()(Event const&, FSM& fsm, SourceState&, TargetState&) {
            while(!fsm.activeQueue.empty()) {
                Goal goal = fsm.activeQueue.front();
                if(goal.getPhoneNumber() != "") fsm.publishNotification(goal.getPhoneNumber(), "sms", "Cannot reach " + goal.getName() + " due to technical difficulties. Aborting.");
                fsm.activeQueue.pop();
            }

            while(!fsm.queue.empty()) {
                Goal goal = fsm.queue.top();
                if(goal.getPhoneNumber() != "") fsm.publishNotification(goal.getPhoneNumber(), "sms", "Cannot reach " + goal.getName() + " due to technical difficulties. Aborting.");
                fsm.queue.pop();
            }
        }
    };

    struct RequestFrontendClearance {
        template<class Event, class FSM, class SourceState, class TargetState>
        void operator()(Event const&, FSM& fsm, SourceState&, TargetState&) {
            fsm.publishCommunication("frontend", "clearance", "", "pending");
        }
    };

    struct TestFnc {
        template<class Event, class FSM, class SourceState, class TargetState>
        void operator()(Event const&, FSM&, SourceState&, TargetState&) {
            
        }
    };

    //////////////// Transition guards ////////////////
    struct ChargeGuard {
        template <class Event, class FSM, class SourceState, class TargetState>
        bool operator()(Event const&, FSM& fsm, SourceState&,TargetState&) {
            return !fsm.charging && fsm.chargeEnough;
        }
    };

    //////////////// Transition table ////////////////
    struct transition_table : boost::mpl::vector<
        // Row<Start, Event, Next, Action, Guard>
        boost::msm::front::Row<Lost, CalibrationSucceeded, Homecoming, MoveToSafePosition, boost::msm::front::none>,
        boost::msm::front::Row<Lost, CalibrationFailed, Lost, NotifyControlRoom, boost::msm::front::none>,
        boost::msm::front::Row<Lost, CalibrationSkipped, Standby, boost::msm::front::none, boost::msm::front::none>,

        boost::msm::front::Row<Homecoming, MovedToSafePosition, Standby, boost::msm::front::none, boost::msm::front::none>,
        boost::msm::front::Row<Homecoming, MoveToSafePositionFailed, Lost, boost::msm::front::none, boost::msm::front::none>,

        boost::msm::front::Row<Standby, Charging, Charge, boost::msm::front::none, boost::msm::front::none>,
        boost::msm::front::Row<Standby, ChargeNotEnough, Charge, boost::msm::front::none, boost::msm::front::none>,
        boost::msm::front::Row<Standby, QueueNotEmpty, PendingFrontendClearance, RequestFrontendClearance, boost::msm::front::none>,

        boost::msm::front::Row<PendingFrontendClearance, FrontendClearance, Delivery, ProcessQueue, boost::msm::front::none>,

        boost::msm::front::Row<Delivery, ChargeNotEnough, Homecoming, boost::msm::front::ActionSequence_<boost::mpl::vector<DropAllRequests, MoveToSafePosition>>, boost::msm::front::none>,
        boost::msm::front::Row<Delivery, GoalFailed, RequestProcessed, EvaluateGoal, boost::msm::front::none>,
        boost::msm::front::Row<Delivery, GoalReached, RequestInteraction, boost::msm::front::none, boost::msm::front::none>,
        
        boost::msm::front::Row<RequestInteraction, RequestInteractionComplete, RequestProcessed, EvaluateGoal, boost::msm::front::none>,
        
        boost::msm::front::Row<RequestProcessed, QueueEmpty, Homecoming, MoveToSafePosition, boost::msm::front::none>,
        boost::msm::front::Row<RequestProcessed, QueueNotEmpty, Delivery, ProcessQueue, boost::msm::front::none>,
        
        boost::msm::front::Row<Charge, ChargingStopped, Standby, boost::msm::front::none, ChargeGuard>,
        boost::msm::front::Row<Charge, QueueNotEmpty, boost::msm::front::none, DropAllRequests, boost::msm::front::none>
    > {};

    // Replaces the default no-transition response.
    template <class FSM, class Event> void no_transition(Event const& e, FSM&,int state) {
    }
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "state_machine");
    
    boost::msm::back::state_machine<HospitalBotStateMachineFrontEnd> backEnd;
    backEnd.start();

    ros::spin();
    return 0;
}
