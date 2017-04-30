#!/usr/bin/env python

import rospy
from beg_tut.msg import string_w_header
import matplotlib.pyplot as plt

class Sub:
	
    def __init__(self):
        self.string_sub = rospy.Subscriber('/pizza',
                string_w_header,
                self.put_in_the_oven)
        self.prev = 0
        self.ts = []
        
    def put_in_the_oven(self, msg):
        t = rospy.Time.now()
        nsec = msg.head.stamp.nsecs
        sec = msg.head.stamp.secs
        #print(t.secs - sec, t.nsecs - nsec)
        if len(self.ts) <= 300:
			self.ts.append(t.nsecs - nsec)
        else:
			plt.hist(self.ts)
			plt.show()


def main():
    #Other nodes know who is publishing
    rospy.init_node('oven_node')
    #Telling the node how often to publish messages
    sub = Sub()
    rospy.spin()

if __name__ == '__main__':
    main()
