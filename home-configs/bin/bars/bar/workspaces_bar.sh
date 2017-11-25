#!/bin/bash

IFS=$'\n'
declare -A workspaces

ws="%{B#474747}%{F#909090}%{U#606060}"
current_deskop=$(xdotool get_desktop)
separator="%{-u}%{B#505050}%{O1}%{B#444}%{+u}"

for desktop in $(wmctrl -d); do
	#echo "key: ${desktop##* }"
	#echo "${desktop%% *}"
	#workspaces[${desktop##* }]=${desktop%% *}
	desktop_id=${desktop%% *}
	desktop_name=${desktop##* }
	workspace="%{A:wmctrl -s $desktop_id:}%{O20}$desktop_name%{O20}%{A}"
	[[ $desktop_id -eq $current_deskop ]] && workspace="%{B#555}%{U#86b437}$workspace%{U#656565}%{B#474747}"
	ws+="$workspace$separator"
done

unset IFS

#for key in ${!workspaces[@]}; do
#	#[[ ${workspace[$key]} -eq $current_deskop ]] && 
#	workspace="%{A:wmctrl -s ${workspaces[$key]}:}%{O20}$key%{O20}%{A}"
#	[[ ${workspaces[$key]} -eq $current_deskop ]] && workspace="%{B#555}%{U#86b437}$workspace%{U#656565}%{B#474747}"
#	ws+="$workspace$separator"
#done

echo -e "WORKSPACES %{c}%{+u}$ws%{-u}%{B#00000000}" 
