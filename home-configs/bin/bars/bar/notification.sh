#!/bin/bash

font1="Monaco:size=9"
font2="Monaco:size=7"
font3="IcoMoon:size=15"
font4="IcoMoon:size=10"

while true; do
	case $5 in
		1) 
			status="$(mpc | sed -n 's/.*\[\(.*\)\].*/\1/p')"
			song_info="$(mpc current -f "%{T1}%title% %{T2}by %{T1}%artist%" | head -c 40)"
			volume="%{T4}%{A:mpc volume -5:} %{A}$(mpc volume | sed 's/.*: \([0-9%]*\).*/\1/') %{A:mpc volume +5:} %{A}" ;;
		2) song_info="$(mpc current -f "%{T1}%title% %{T2}by %{T1}%artist%" | head -c 40)" ;;
		3) album_info="$(mpc current -f "%{T2}from %{T1}%album%" | head -c 40)" ;;
	esac

	eval "$1"
	sleep 1
done | lemonbar -p -B#dd333333 -F#cecece -f "$font1" -o $4 \
					 -f "$font2" -o -4 \
					 -f "$font3" -o 7 \
				       	 -f "$font4" -o 5 -f "$font1" -o -11 -n 'song_notify' -a 55 -g 250x$2+1120+$3 | bash
wait
