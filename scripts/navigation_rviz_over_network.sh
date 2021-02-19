#!/bin/bash
source config
export ROS_IP=$LOCAL_IP
export ROS_HOSTNAME=$LOCAL_IP
export ROS_MASTER_URI="http://$ROBOT_IP:$ROBOT_ROS_PORT"
source "$ROS_ENVIRONMENT/devel/setup.bash"
rosrun rviz rviz -d "$NAVIGATION_RVIZ_FILE"
