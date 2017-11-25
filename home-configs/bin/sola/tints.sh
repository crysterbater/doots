#!/bin/bash

#tint2 -c ~/Desktop/workspace_switcher_background &
#sleep 0.1
#tint2 -c ~/Desktop/workspace_switcher &

tint2 -c ~/Desktop/workspace_switcher_background &

until pid=$(ps -ef | awk '/tint2.*background/ && !/awk/ {print $2}'); do
	sleep 0.1
done

tint2 -c ~/Desktop/workspace_switcher &
