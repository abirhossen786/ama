#include <csignal>
#include <unistd.h>
#include <ros/ros.h>
#include <hospitalbot/RobotState.h>
#include <hospitalbot/Communication.h>
#include <boost/thread.hpp>

const std::string COMMUNICATION_TOPIC = "/hospitalbot/communication";
const std::string ROBOT_STATE_TOPIC = "/hospitalbot/robot_state";
pid_t pid;

int main(int argc, char** argv) {
    ros::init(argc, argv, "launch_manager");
    ros::NodeHandle n("~");

    ros::Publisher robotStatePublisher = n.advertise<hospitalbot::RobotState>(ROBOT_STATE_TOPIC, 10, true);    

    boost::function<void()> publishIndexState = [&]() {
        hospitalbot::RobotState robotStateMessage;
        robotStateMessage.id = 0;
        robotStateMessage.activity = 0;
        robotStateMessage.message = "";

        robotStatePublisher.publish(robotStateMessage);
    };

    ros::Subscriber communicationSubscriber = n.subscribe(COMMUNICATION_TOPIC, 10,
        static_cast<const boost::function<void(const hospitalbot::Communication::ConstPtr&)>>([&](const hospitalbot::Communication::ConstPtr& communication) {
            if(communication->source == "frontend" && communication->target == "backend" && communication->type == "launch" && communication->metadata == "drive" && communication->status == "start") {
                pid = fork();
                if(pid == 0) {
                    execlp("roslaunch", "roslaunch", "hospitalbot", "drive.launch", (char *) 0);
                    exit(0);
                }
            }
            else if(communication->source == "frontend" && communication->target == "backend" && communication->type == "launch" && communication->metadata == "drive" && communication->status == "stop") {
                kill(pid, SIGTERM);
                publishIndexState();
            }
        })
    );

    publishIndexState();

    ros::spin();    
    return 0;
}