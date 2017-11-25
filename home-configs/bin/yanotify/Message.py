# -*- coding: utf-8 -*-

class Message():
    def __init__(self, args):
        self.choose_program(args)

    def get(self):
        return self.program + ' ' + self.title + ': ' + self.body

    def set_normal(self, args):
    	self.program = '(' + str(args[0]) + ')'
    	self.title = str(args[3])
    	self.body = str(args[4])

    def set_spotify(self, args):
        self.program = str('')
        self.title = str(args[4].split(' - ')[0])
    	self.body = str(args[3].split(' - ')[0])

    def set_networkmanager(self, args):
    	self.program = str('')
    	self.title = str(args[3])
    	self.body = str(args[4])

    def set_slack(self, args):
    	self.program = str('')
    	self.title = str(args[3].split(' ', 2)[2])
    	self.body = str(args[4])

    def choose_program(self, args):
    	program = args[0]
    	if program == "Spotify":
    		self.set_spotify(args)
    	elif program == "Electron":
    		self.set_slack(args)
    	elif program == "NetworkManager":
    		self.set_networkmanager(args)
    	else:
    		self.set_normal(args)
