#!/usr/bin/env python

from beg_tut.srv import Service1
import rospy
import numpy as np
import matplotlib.pyplot as plt

def main():
	rospy.init_node('AdjFunc1')
	ts = []
	rospy.wait_for_service('serv1')
	services = rospy.ServiceProxy('serv1', Service1)
	i = 0
	while i <= 300:
		t1 = rospy.Time.now()
		resp = services(i%4)
		t2 = rospy.Time.now()
		ts.append(t2.nsecs - t1.nsecs)
		i = i + 1
		
	plt.hist(ts)
	plt.show()
	
if __name__ == "__main__":
	main()
