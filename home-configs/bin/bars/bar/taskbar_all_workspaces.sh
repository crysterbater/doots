#!/bin/bash

#bg="%{B#333}"
default_bg="%{B#292929}"	#454d54		3d444c
active_desktop_bg="%{B#393939}"	#575e66
active_window_bg="%{B#474747}"	#676d73
fg="%{F#999}"
sep="%{B#00000000}"
all_windows="$bg$fg%{U#B4C754}"

active_desktop=$(xdotool get_desktop)
desktop_count=$(xdotool get_num_desktops)
active_id=$(printf 0x%x $(xdotool getactivewindow 2> /dev/null))

readarray -t windows <<< "$(wmctrl -l | awk '$2 != '-1'' | sort -n -k 2)"

for desktop in $(seq 0 $((desktop_count - 1))); do
	#[[ $desktop -eq $active_desktop ]] && bg="%{B#404040}" || bg="%{B#333}"
	#[[ $desktop -eq $active_desktop ]] && bg="%{B#4e545c}" || bg="%{B#333}"
	#[[ $desktop -eq $active_desktop ]] && bg="%{B#575e66}" || bg="%{B#3d444c}"
	[[ $desktop -eq $active_desktop ]] && bg=$active_desktop_bg|| bg=$default_bg
	all_windows+="$bg"

	while true; do
		window="$(echo ${windows[$index]} | awk '$2 == '$desktop' { print }')"
		if [[ $window ]]; then
			window_id=${window%% *}
			window_name="%{O25}${window#*$(hostname)}%{O25}"

			[[ ${#window_name} -gt 35 ]] && window_name="${window_name::25}..%{O25}"
			#[[ ${window%% *} =~ ${active_id#0x} ]] && window_name="%{+u}%{B#575E66}$window_name$bg%{-u}"
			#[[ ${window%% *} =~ ${active_id#0x} ]] && window_name="%{+u}%{B#4a4a4a}$window_name$bg%{-u}"
			#[[ ${window%% *} =~ ${active_id#0x} ]] && window_name="%{+u}%{B#676d73}$window_name$bg%{-u}"
			[[ ${#active_id} > 3 && ${window%% *} =~ ${active_id#0x} ]] && window_name="%{+u}$active_window_bg$window_name$bg%{-u}"

			all_windows+="%{A2:wmctrl -i -c $window_id:}%{A:wmctrl -i -a $window_id:}$window_name%{A}%{A}$sep%{O2}$bg"

			(( index++ ))
		else
			break
		fi
	done

	[[ $index -ne $last_index ]] && all_windows+="$sep%{O5}"
	last_index=$index
done

echo -e "%{c}$all_windows%{B#00000000}"
