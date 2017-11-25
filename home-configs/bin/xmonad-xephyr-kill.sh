#!/bin/sh

PID=$(ps aux | grep Xephyr | grep :3 | grep -v grep | awk '{ print $2 }')

if [ ! -z $PID ]; then
	kill $PID
fi
