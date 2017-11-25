#!/bin/bash

walls_dir=~/Pictures/demo

IFS=$'\n'
walls=( $(find $walls_dir -type f) )
unset IFS

current_desktop="desktop_$(xdotool get_desktop)"

for wall in $(sed -n "s/$current_desktop \(.*\)/\1/p" ~/.walls); do
	walls_to_set+="${walls[$wall]} "
done

DISPLAY=:0 feh --bg-scale $walls_to_set
