#!/usr/bin/env python
import sys, select, tty, termios, socket, atexit

if __name__ == '__main__':
    # Each address on the Internet is identified by an ip-address
    # and a port number.
    robot_ip_address = "192.168.0.3"  # Change to applicable
    robot_port       = 5000            # Change to applicable
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.connect((robot_ip_address, robot_port))
    print("Connected to ", robot_ip_address, " on port ", robot_port)

    # BEGIN TERMIOS
    old_attr = termios.tcgetattr(sys.stdin)
    tty.setcbreak(sys.stdin.fileno())
    atexit.register(termios.tcsetattr, sys.stdin, termios.TCSADRAIN, old_attr)
    # END TERMIOS
    while True:
        if select.select([sys.stdin], [], [], 0)[0] == [sys.stdin]:
            key = sys.stdin.read(1)
            print("Sending ", key.lower())
            s.send(key.lower())
    s.close()


    
