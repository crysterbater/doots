#!/bin/bash

mode=$1
sign=$2
value=$3
direction=$4
current_desktop=$(xdotool get_desktop)
id=$(printf 0x%x $(xdotool getactivewindow))
properties=( $(wmctrl -l -G | awk '$1 ~ /'${id#*0x}'/ {print $3 - 2 " " $4 - 20 " " $5 " " $6}') )

if [[ $mode == 'resize' ]]; then
	((properties[2] ${sign}= $value))
	[[ $sign == + ]] && extra_width=2 || extra_width=5
	[[ $sign == + ]] && oposite_sign=- || oposite_sign=+
	[[ $direction == left ]] && ((properties[0] ${oposite_sign}= (value - 2)))
	((properties[2] += $extra_width))
else
	[[ $direction == x ]] && index=0 || index=1
	((properties[$index] ${sign}= $value))
fi

wmctrl -ir $id -e 0,${properties[0]},${properties[1]},${properties[2]},${properties[3]}
