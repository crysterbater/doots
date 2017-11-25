#!/bin/sh

if [ "$(ps aux | grep Xephyr | grep -v grep | grep -vi virtualbox | wc -l)" -lt 1 ]; then
	exec Xephyr -screen 1366x752 -terminate -title "Xmonad" :3 &
	xdotool search --classname "Xephyr" windowmove 0 16
	xdotool search --classname "Xephyr" windowsize 1366 752
	sleep 1
	export DISPLAY=:3
	exec xfce4-session
	sleep 1
	exe=`dmenu_run_xephyr -nb black -sb black -nf "#555753" -sf "#8AE234"`
	eval "exec $exe"
else
	export DISPLAY=:3
	exe=`dmenu_run_xephyr -nb black -sb black -nf "#555753" -sf "#8AE234"`
	eval "exec $exe"

fi
