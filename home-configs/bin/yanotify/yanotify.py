# -*- coding: utf-8 -*-

import time, sys
import glib
import dbus
from dbus.mainloop.glib import DBusGMainLoop
from threading import Thread
import gobject
from MessageList import MessageList
from InputReceiver import InputReceiver
from Message import Message

DEBUG = False

class YaNotify():
	def __init__(self):

		self.messages = MessageList()
		self.receiver = InputReceiver(self.input_handler)

		self.init_bus_connection()

		#MainLoop
		gobject.threads_init()
		mainloop = glib.MainLoop()
		mainloop.run()

	def init_bus_connection(self):
		DBusGMainLoop(set_as_default=True)

		bus = dbus.SessionBus()
		bus.add_match_string_non_blocking("eavesdrop=true, interface='org.freedesktop.Notifications', member='Notify'")
		bus.add_message_filter(self.get_notification)


	def get_notification(self, bus, message):
		args = message.get_args_list()

		try:
			m = Message(args)
			self.messages.handle(m)
		except Exception,e:
			if DEBUG:
				print e

	def input_handler(self, s):
		s = s.split(" ")

		if(s[0] == "Smart"):
			smart = True
			s.pop(0)
		else:
			smart = False

		if(s[0] == "Up"):
			self.messages.navigate(-1, smart)
		elif(s[0] == "Down"):
			self.messages.navigate(1, smart)

if __name__ == "__main__":
	if len(sys.argv) > 1 and sys.argv[1] == '-d':
		DEBUG = True
	YaNotify()
