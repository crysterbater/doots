#!/bin/bash

ids=( $(wmctrl -l | awk 'NR > 1 && !/N\/A/ {print $1}') )
active_id=$(printf 0x%x $(xdotool getactivewindow))

taskbar="%{c}%{T1}%{B#4a4a4a}%{F#888}%{U#E6C650}"
separator="%{B#00000000}%{O5}%{B#4a4a4a}"

for id in ${ids[*]}; do
	window_name=$(xprop -id $id | awk -F '"' '/^WM_NAME/ {print $2}' )
	[[ ${#window_name} -gt 20 ]] && window_name="${window_name::18}.."

	if [ ${id: -6} == ${active_id: -6} ]; then
		#window_name="%{F#303030}%{B#303030}%{F#cecece}%{+u}%{O20}$window_name%{O20}%{-u}%{B#4a4a4a}%{F#303030}%{F#888}"
		window_name="%{B#404040}%{F#cecece}%{+u}%{O20}$window_name%{O20}%{-u}%{B#4a4a4a}"
		offset=0
	else
		offset=20
	fi

	taskbar+="%{A:wmctrl -i -a $id:}%{O$offset}$window_name%{O$offset}%{A}$separator"
done

echo "$taskbar%{B#aa545454}%{F#B2AC98}" 
