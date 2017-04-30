#!/usr/bin/env python

from beg_tut.srv import *
import rospy
import numpy as np

class RoomService:
	def __init__(self):
		s = rospy.Service('serv1', Service1, self.get_adjacent_rooms)
		self.adj_rooms = [[1,1,1,0,1],[1,1,1,0,0],[1,1,1,1,0],[1,0,0,0,1]]
		
	def get_adjacent_rooms(self,req):
		room_num = req.room_num
		adj = self.adj_rooms[room_num]
		return Service1Response(adj)
		
def main():
	rospy.init_node('AdjFunc')
	rs = RoomService()
	rospy.spin()
	
if __name__ == "__main__":
	main()
