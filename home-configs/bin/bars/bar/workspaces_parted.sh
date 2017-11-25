#!/bin/bash

#workspaces="%{B#474747}%{F#909090}%{U#6a6a6a}"
#separator="%{B#555}%{O1}%{B#474747}"
#current_deskop=$(xdotool get_desktop)
bg="%{B#404040}"	#575e66
active_bg="%{B#555}"
separator="%{B#555}%{O1}$bg"
workspaces="$bg%{F#999}%{U#b4c754}%{-u}"

current_deskop=$(xdotool get_desktop)

while read -r desktop; do
	desktop_id=${desktop%% *}
	desktop_name=${desktop##* }
	workspace="%{A:wmctrl -s $desktop_id:}%{O20}$desktop_name%{O20}%{A}"
	#[[ $desktop_id -eq $current_deskop ]] && workspace="%{B#555}%{U#B4C754}$workspace%{U#6a6a6a}%{B#474747}"
	[[ $desktop_id -eq $current_deskop ]] && workspace="$active_bg%{+u}$workspace%{-u}$bg"

	workspaces+="$workspace"
	(( desktop_id < $(xdotool get_num_desktops) - 1 )) && workspaces+="$separator"
done <<< "$(wmctrl -d)"

echo -e "%{+u}$workspaces%{-u}"
