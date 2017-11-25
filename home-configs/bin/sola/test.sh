#!/bin/bash

#echo "current time: $(/bin/date +%T)" >> /home/sola/Desktop/test_date
#DISPLAY=:0 /usr/bin/notify-send "current time: $(/bin/date +%T)" 
#DISPLAY=:0 /usr/bin/feh --bg-scale /home/sola/Pictures/walls/6856216-moss-wallpaper-hd.jpg
#DISPLAY=:0 feh --bg-scale /home/sola/Pictures/walls/branch_wallpaper.jpg
#DISPLAY=:0 /usr/bin/thunar /home/sola/Documents
#count=$(ls /home/sola/Desktop/touched* 2> /dev/null | wc -l )
#touch /home/sola/Desktop/touched_file_$count

walls_dir=/home/sola/Pictures/walls

IFS=$'\n'
walls=( $(find $walls_dir -maxdepth 1) )
unset IFS

walls_count=${#walls[*]}

function set_walls() {
	#display_count=$(xrandr -q | grep ' connected' | wc -l)
	display_count=1

	for display in $(seq $display_count); do
		wall_index="$(($1))"
		walls_indexes+="$wall_index "
		walls_to_set+="'${walls[$wall_index]}' "
	done

	sed -i "s/\($current_desktop\).*/\1 $walls_indexes/" /home/sola/.walls
	#eval "DISPLAY=:0 feh --bg-scale $walls_to_set"
	eval "DISPLAY=:0 feh --bg-scale $walls_to_set"
	#feh --bg-scale "$walls_to_set"
}

#desktop_number=$(xdotool get_desktop)
#desktop_number=$(/usr/bin/wmctrl -d | awk '$2 == "*" {print $1}')
#desktop_number=$(xprop -root _NET_CURRENT_DESKTOP | tail -c 2)
desktop_number=0
current_desktop="desktop_${desktop_number}"
#current_desktop="desktop_$(/usr/bin/xdotool get_desktop)"
current_wall_index=$(awk '/'$current_desktop'/ {print $2}' /home/sola/.walls)

set_walls "RANDOM % walls_count"
echo "$current_wall_index desktop $current_desktop : $walls_to_set" >> /home/sola/Desktop/test_date

#display_count=$(xrandr -q | grep ' connected' | wc -l)
#
#for display in $(seq $display_count); do
#	wall_index="$(($1))"
#	walls_indexes+="$wall_index "
#	walls_to_set+="'${walls[$wall_index]}' "
#done
#
#sed -i "s/\($current_desktop\).*/\1 $walls_indexes/" /home/sola/.walls
#DISPLAY=:0 /usr/bin/feh --bg-scale "$walls_to_set"

#set_walls "RANDOM % walls_count"
#if [[ -z $current_wall ]]; then
#	case $1 in
#		previous)
#			((index = current_wall_index == 0 ? walls_count : current_wall_index))
#			set_walls "index - 1" ;;
#		next)
#			set_walls "(current_wall_index + 1) % walls_count" ;;
#		*)
#			set_walls "RANDOM % walls_count"
#	esac
#fi
