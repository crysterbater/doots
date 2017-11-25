#!/bin/bash

font1="Monaco:size=10"
font2="IcoMoon:size=10"

bar_width=400
bar_height=150

#screen_width=$(xrandr -q | grep -w connected | awk -F '[ x+]' '{print $3}')
#screen_height=$(xrandr -q | grep -w connected | awk -F '[ x+]' '{print $4}')
#screen_width=1400
#screen_height=1050
screen_width=1920
screen_height=1080

restart="%{A:systemctl reboot:}restart%{A}"
suspend="%{A:systemctl suspend:}suspend%{A}"
shut_down="%{A:systemctl poweroff:}shut down%{A}"

#pid="\$(for pid in \$(pidof lemonbar); do echo \$pid \$(ps -p \$pid -o etimes=); done | sort -n -k2 | awk 'NR == 1 {print \$1}'"
pid='$(for pid in $(pidof lemonbar); do echo $pid $(ps -p $pid -o etimes=); done | sort -n -k2 | head -n 1 | cut -d " " -f 1)'
close="%{A:kill "$pid":} %{A}"

echo -e "%{c}$restart%{O50}$suspend%{O50}$shut_down%{r}%{F#888}%{T2}$close%{O10}" | lemonbar -p -B#ee404040 -F#c2c2c2 \
				-f "$font1" -o 5 \
				-f "$font2" -o -55 \
				-g ${bar_width}x${bar_height}+$((screen_width / 2 - bar_width / 2))+$((screen_height / 2 - bar_height / 2)) -n shut_down_bar | bash
