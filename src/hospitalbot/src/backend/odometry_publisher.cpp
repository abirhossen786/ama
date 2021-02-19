#include <ros/ros.h>
#include <tf/transform_datatypes.h>
#include <nav_msgs/Odometry.h>
#include <hospitalbot/Motor.h>
#include <sensor_msgs/Imu.h>

const std::string WHEEL_DATA_TOPIC = "/hospitalbot/wheel_data";
const std::string IMU_TOPIC = "/imu";

double x = 0.0;
double y = 0.0;
double theta = 0.0;
geometry_msgs::Quaternion orientation;
double velocityRobotX = 0.0;
double omegaRobot = 0.0;
ros::Time currentTime;

double odomLeftVelocityMultiplier = 1.0;
double odomRightVelocityMultiplier = 1.0;
double odomTurnMultiplier = 1.0;

double lastWheelTime = 0.0;
double currentWheelTime = 0.0;

bool wheelDataReceived = false;
bool imuDataReceived = false;

void wheelCallback(const hospitalbot::Motor::ConstPtr &wheelData) {
    if(imuDataReceived) {
        if(!wheelDataReceived) {
            wheelDataReceived= true;
            lastWheelTime = currentWheelTime = wheelData->time;
        }

        velocityRobotX = (wheelData->left_velocity + wheelData->right_velocity) / 2.0;
        double velocityRobotY = 0;
        currentWheelTime = wheelData->time;

        double deltaTime = currentWheelTime - lastWheelTime;
        double latestTheta = theta;
        double velocityOdomX = (velocityRobotX * cos(latestTheta) - velocityRobotY * sin(latestTheta)) * odomLeftVelocityMultiplier;
        double velocityOdomY = (velocityRobotX * sin(latestTheta) + velocityRobotY * cos(latestTheta)) * odomRightVelocityMultiplier;
        double omegaOdom = omegaRobot * odomTurnMultiplier;

        x += velocityOdomX * deltaTime;
        y += velocityOdomY * deltaTime;
        // theta += omegaOdom * deltaTime;
        //theta += deltaAngle;
        
        lastWheelTime = currentWheelTime;
    }
}

void imuCallback(const sensor_msgs::Imu::ConstPtr &imuData) {
    if(!imuDataReceived) imuDataReceived = true;
    orientation = imuData->orientation;
    //theta = 2 * acos(orientation.w);

    tf::Matrix3x3 m(tf::Quaternion(imuData->orientation.x, imuData->orientation.y, imuData->orientation.z, imuData->orientation.w));
    double roll, pitch, yaw;
    m.getRPY(roll, pitch, yaw);
    theta = yaw;

    omegaRobot = imuData->angular_velocity.z;
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "odometry_publisher");

    ros::NodeHandle n;

    ros::Subscriber wheelDataSubscriber = n.subscribe(WHEEL_DATA_TOPIC, 1000, wheelCallback);
    ros::Subscriber imuSubscriber = n.subscribe(IMU_TOPIC, 1000, imuCallback);

    ros::Publisher odomPublisher = n.advertise<nav_msgs::Odometry>("odom", 50);

    ros::Rate rate(100.0);

    while(n.ok()) {
        ros::spinOnce();
        if(wheelDataReceived && imuDataReceived) {
            currentTime = ros::Time::now();
            //ROS_INFO("omega is %lf, theta is %lf", omegaRobot, theta * (180.0 / 3.14159));

            //geometry_msgs::Quaternion odomQuaternion = tf::createQuaternionMsgFromYaw(theta);
            
            nav_msgs::Odometry odometry;
            odometry.header.stamp = currentTime;
            odometry.header.frame_id = "odom";
            odometry.child_frame_id = "base_footprint";

            odometry.pose.pose.position.x = x;
            odometry.pose.pose.position.y = y;
            odometry.pose.pose.position.z = 0.0;
            odometry.pose.pose.orientation = orientation;

            odometry.twist.twist.linear.x = velocityRobotX;
            odometry.twist.twist.linear.y = 0.0;
            odometry.twist.twist.linear.z = 0.0;
            odometry.twist.twist.angular.x = 0.0;
            odometry.twist.twist.angular.y = 0.0;
            odometry.twist.twist.angular.z = omegaRobot;

            odomPublisher.publish(odometry);
        }
        rate.sleep();
    }
    return 0;
}