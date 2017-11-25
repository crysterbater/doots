#!/bin/bash

walls_dir=~/Pictures/walls
#walls_dir=~/Downloads/walls

#for recursive directories
IFS=$'\n'
#walls=( $(find $walls_dir -type f -regex ".*\(jpg\|png\)") )
walls=( $(find $walls_dir -type f) )
#walls=( $(find Pictures/walls -maxdepth 1) )
unset IFS

#walls=( $walls_dir/* )
walls_count=${#walls[*]}

function set_walls() {
	display_count=$(xrandr -q | grep ' connected' | wc -l)

	for display in $(seq $display_count); do
		wall_index="$(($1))"
		walls_indexes+="$wall_index "
		walls_to_set+="'${walls[$wall_index]}' "
	done

	sed -i "s/\($current_desktop\).*/\1 $walls_indexes/" ~/.walls
	eval "DISPLAY=:0 feh --bg-scale $walls_to_set"
}

current_desktop="desktop_$(xdotool get_desktop)"
current_wall_index=$(awk '/'$current_desktop'/ {print $2}' ~/.walls)

if [[ -z $current_wall ]]; then
	case $1 in
		previous)
			((index = current_wall_index == 0 ? walls_count : current_wall_index))
			set_walls "index - 1" ;;
		next)
			set_walls "(current_wall_index + 1) % walls_count" ;;
		*)
			set_walls "RANDOM % walls_count"
	esac
fi
