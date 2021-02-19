#!/usr/bin/env python
# BEGIN ALL
import socket
import rospy
import atexit
from std_msgs.msg import String

if __name__ == '__main__':
  key_pub = rospy.Publisher('keys', String, queue_size=1)
  rospy.init_node("keyboard_driver")
  

  # BEGIN NETWORK INIT
  robot_port = 5000  # Change to applicable
  s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
  s.bind(("", robot_port))
  s.listen(5)
  atexit.register(s.close)
  # END NETWORK INIT

  print ("Publishing keystrokes. Press Ctrl-C to exit...")
  while not rospy.is_shutdown():
    print ("Waiting for connection...")
    (c, c_addr) = s.accept()
    print ("New connection from: ", c_addr)

    while not rospy.is_shutdown():
      command = c.recv(1)
      if(command == ""):
        break
      print("Publishing ", command)
      key_pub.publish(command)
# END ALL