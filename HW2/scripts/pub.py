#!/usr/bin/env python

import rospy
from std_msgs.msg import String
from beg_tut.msg import string_w_header

class Pub:
    def __init__(self):
        self.string_pub = rospy.Publisher('/pizza', string_w_header, queue_size = 1)

    def pub_msg(self):
        a = 'Pepperoni'
        msg = string_w_header()
        msg.s = a
        msg.head.stamp = rospy.Time.now()
        self.string_pub.publish(msg)

def main():
    #Other nodes know who is publishing
    rospy.init_node('pizza_node')
    #Telling the node how often to publish messages
    rate = rospy.Rate(30)
    pub = Pub()
    #While the user doesn't terminate the program run this
    while not rospy.is_shutdown():
        pub.pub_msg()
        #makes sure the program runs at 10 hz
        rate.sleep()

if __name__ == '__main__':
    main()
