#!/usr/bin/env python
import serial
import rospy
from hospitalbot.msg import Communication

if __name__ == '__main__':
    rospy.init_node('goal_command_publisher')
    
    ser = serial.Serial(rospy.get_param("~arduino_port"), 115200)

    goal_command_pub = rospy.Publisher('/hospitalbot/communication', Communication, queue_size = 5)

    def notification_callback(communication):
        if(communication.source == 'backend' and communication.target == 'arduino' and communication.type == 'call'):
            ser.write(communication.metadata)

    notification_sub = rospy.Subscriber('/hospitalbot/communication', Communication, notification_callback)

    r = rospy.Rate(10) 
    
    while not rospy.is_shutdown():
        try:
            raw = ser.readline()
            if(raw == 'ready'):
                rospy.loginfo("GSM Arduino: init complete")
            else:
                phone, sms = raw.split()
                
                message = Communication()
                message.source = 'arduino'
                message.target = 'backend'
                message.type = 'sms'
                message.metadata = phone
                message.status = sms

                goal_command_pub.publish(message)
        except:
            r.sleep()
            continue
        
        r.sleep()