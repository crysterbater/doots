#!/bin/bash

#font1="consolas:size=11"
font1="Monaco for Powerline:size=10"
#font1="Hack:size=10"
font2="IcoMoon:size=10"
font3="FontAwesome:size=9"
#font4="consolas:size=9:weight=heavy"
font4="Monaco for Powerline:size=10"
#font4="Monaco for Powerline:size=9"
#font4="Hack:size=10"
font5="Monaco:size=9"
font6="Monaco for Powerline:size=12"

#while read -r desktop; do
#	desktop_name=${desktop##* }
#	(( length+=((${#desktop_name} * 7) + 40) ))
#done <<< "$(wmctrl -d)"
#
#width=$((960 - length / 2))

~/Desktop/bar/main.sh "#404040" "$font1" "$font2" "$font3" "$font4" "$font5" "$font6" &
#~/Desktop/bar/media_bar.sh "#00000000" "$font1" "$font2" "$font3" "$font4" "$font5" $width &
#~/Desktop/bar/main_bar.sh "#00000000" "$font1" "$font2" "$font3" "$font4" $width &
#
#while true; do
#	~/Desktop/bar/taskbar_all_workspaces.sh
#	sleep 1
#done | lemonbar -p -B#00000000 -F#999 -f "$font5" -a 30 -b -u 2 -g x22+0+10 -n taskbar_bar | bash &
