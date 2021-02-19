#include <ros/ros.h>
#include <std_msgs/String.h>
#include <geometry_msgs/Twist.h>
#include <vector>
#include <map>

geometry_msgs::Twist lastTwist;
std::map< std::string, std::vector< double > > keyMap;

void initializeKeyMap(double linearVelocity, double angularVelocity) {
    keyMap["w"].push_back(0);
    keyMap["w"].push_back(linearVelocity);

    keyMap["x"].push_back(0);
    keyMap["x"].push_back(-linearVelocity);

    keyMap["a"].push_back(angularVelocity);
    keyMap["a"].push_back(0);

    keyMap["d"].push_back(-angularVelocity);
    keyMap["d"].push_back(0);

    keyMap["s"].push_back(0);
    keyMap["s"].push_back(0);
}
ros::Publisher twistPublisher;
ros::Subscriber keySubscriber;

void keysCallback(const std_msgs::String::ConstPtr &message) {
    if(message->data.length() == 0 || keyMap.find(message->data) == keyMap.end()) return;
    lastTwist.angular.z = keyMap[message->data][0];
    lastTwist.linear.x = keyMap[message->data][1];
    twistPublisher.publish(lastTwist);
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "command_twist_publisher");
    
    ros::NodeHandle nodeHandle("~");

    twistPublisher = nodeHandle.advertise<geometry_msgs::Twist>("/cmd_vel", 1);
    keySubscriber = nodeHandle.subscribe("/keys", 50, keysCallback);

    double linearVelocity, angularVelocity;
    nodeHandle.param< double >("linear_velocity", linearVelocity, 0.25);
    nodeHandle.param< double >("angular_velocity", angularVelocity, 0.5);

    initializeKeyMap(linearVelocity, angularVelocity);

    ROS_INFO("Using linear velocity %lf and angular velocity %lf", linearVelocity, angularVelocity);

    ros::Rate rate(10);

    while(nodeHandle.ok()) {
        ros::spinOnce();
        // twistPublisher.publish(lastTwist);
        rate.sleep();
    }

    return 0;
}