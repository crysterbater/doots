#!/bin/bash

foreground=fdf6e7
background=505050
font=tewi:size=10
while :; do
	title=$(xtitle)
	if [[ $title = "" ]]; then
		title="openbox"
	fi
	echo "%{c}$title      "
	sleep 0.5
done | lemonbar -g 1420x30+110+30 -B \#FF$background -F \#FF$foreground -f $font 
