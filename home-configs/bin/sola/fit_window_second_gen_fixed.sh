#!/bin/bash

window_id=$(printf 0x%x $(xdotool getactivewindow))

if [[ "$(grep $window_id ~/Documents/original_properties.txt 2> /dev/null)" && -z "$1" ]]; then
	#wmctrl -ir $window_id -b toggle,maximized_vert
        $(grep $window_id ~/Documents/original_properties.txt)
        sed -i "/$window_id/d" ~/Documents/original_properties.txt

	#if [ $(cat ~/Documents/original_properties.txt | wc -l) -eq 0 ]; then rm ~/Documents/original_properties.txt; fi
	#[[ -s ~/Documents/original_properties.txt ]] && rm ~/Documents/original_properties.txt
	[[ -z $(cat ~/Documents/original_properties.txt) ]] && rm ~/Documents/original_properties.txt
elif [[ $# -gt 1 ]]; then ~/Desktop/resize_window.sh $@
else
	current_desktop=$(xdotool get_desktop)

	while read -r line; do
		window_properties="$(echo $line | awk '{print $1" "$3" "$4" "$5" "$6}')"
		[[ $window_properties =~ ${window_id#0x*} ]] && current_window_properties=( ${window_properties#* } ) && continue
		properties+=("$window_properties")
	done <<< "$(wmctrl -l -G | awk '$2 == '$current_desktop'')"
	#done <<< "$(wmctrl -l -G | awk '!/'${window_id:3}'/ && $2 == '$current_desktop'')"

	window_x=$((${current_window_properties[0]} - 1))
	window_y=$((${current_window_properties[1]} - 36))
	window_width=${current_window_properties[2]}
	window_height=${current_window_properties[3]}

	display_count=0

	while read line; do
		((display_count++))
		declare display_$display_count="$(echo $line | awk -F '[ + ]' '{print $4}')"
	done <<< "$(xrandr -q | grep -w 'connected')"	

	ids=( $(wmctrl -l | awk '$2 == '$current_desktop' {print $1}' | grep -v "${window_id:3:10}") )
	x_offset=30

	for display in $(seq $display_count); do
		display="display_$display"
		display_width=$(echo ${!display} | cut -d 'x' -f1)
		display_height=$(echo ${!display} | cut -d 'x' -f2)

		((max_point += display_width))

		if ((min_point + display_width <= $window_x)); then
			((min_point += display_width))
		else
			#if [ $display == "display_1" ]; then ((min_point += $(pidof lemonbar | awk '{print NF}') > 1 ? 50 : 0 )); fi
			min_point=$x_offset
			break
		fi
       	done

	for p in "${properties[@]}"; do
		window_properties=( ${p#* } )
		x=${window_properties[0]}
		width=${window_properties[2]}
		height=${window_properties[3]}

		if ((height >= display_height - 100 && width < display_width && x > min_point && x < max_point)); then
			if ((x - 2 == min_point)); then position='r'; fi
			((used_width += (width + x_offset)))
			((add_x += x_offset))
		fi
	done

	#if [ $position ]; then
	#	((min_point += (used_width + add_x)))
	#else
	#	((max_point -= (used_width + add_x)))
	#fi
	[[ $position ]] && ((min_point += (used_width + add_x))) || ((max_point -= (used_width + add_x)))

	properties=( "${current_window_properties[@]}" )

	if [ -z $1 ]; then
		command="wmctrl -ir $window_id  -e 0,$((window_x - 1)),$((window_y + 16)),$window_width,$window_height"
		echo $command >> ~/Documents/original_properties.txt
	fi

	wmctrl -ir $window_id -e 0,$min_point,50,$(((max_point - min_point) - x_offset)),$((display_height - 80))
	#wmctrl -ir $window_id -e 0,$min_point,22,$(((max_point - min_point) - 2)),${properties[3]} #&&
	#wmctrl -ir $window_id -b toggle,maximized_vert
fi
