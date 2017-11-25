#!/bin/bash

workspaces="%{F#707070}"

current_desktop=$(xdotool get_desktop)
desktop_count=$(xdotool get_num_desktops)

for desktop in $(seq 0 $((desktop_count - 1))); do
	#[[ $desktop == $current_desktop ]] && icon="%{F#aaa} %{F#777}" || icon=" "
	[[ $desktop == $current_desktop ]] && icon="%{F#aaa} %{F#707070}" || icon=" "
	workspaces+="%{A:wmctrl -s $desktop:}$icon%{A}"
done

echo -e "$workspaces"
