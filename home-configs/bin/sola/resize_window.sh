#!/bin/bash

sign=$1
width=$2
direction=$3

id=$(printf 0x%x $(xdotool getactivewindow))

current_desktop=$(xdotool get_desktop)

#window=$(wmctrl -l -G | awk '$1 ~ /'${id#*0x}'/ {print "0," $3 "," $4 - 18 "," $5 "," $6}')
#properties=$(wmctrl -l -G | awk '$1 ~ /'${id#*0x}'/ {print "0," $3 "," $4 "," "$((" $5 " '$sign' '$width'" "))," $6}')
#window_properties="$(echo $line | awk '{print $1" "$3" "$4" "$5" "$6}')"
#echo "$window"
#properties=$(wmctrl -l -G | awk '$1 ~ /'${id#*0x}'/ {print "0," $3 - 2 "," $4 - 20 "," $5 '$sign' '$width' "," $6}')
properties=( $(wmctrl -l -G | awk '$1 ~ /'${id#*0x}'/ {print $3 - 2 " " $4 - 20 " " $5 " " $6}') )
#echo $((${properties[0]} $sign $width))
#wmctrl -ir $id -e $properties

#[[ $direction == left ]] && properties[0]=$((${properties[0]} $sign $width)) ||
#	properties[2]=$((${properties[2]} $sign $width))

((properties[2] ${sign}= $width))
[[ $sign == + ]] && oposite_sign=- || oposite_sign=+
[[ $direction == left ]] && ((properties[0] ${oposite_sign}= $width))

#echo ${properties[*]}
wmctrl -ir $id -e 0,${properties[0]},${properties[1]},${properties[2]},${properties[3]}
