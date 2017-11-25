#!/bin/bash

current_workspace=$(wmctrl -d | awk '/ \* / {print $NF}')

for workspace in $(seq 1 $1); do
	[ $workspace -eq $current_workspace ] && icon=" " || icon=" "
	workspaces+="%{A:wmctrl -s $((workspace - 1)):}$icon%{A}"
done

echo -e "%{O30}$workspaces%{O30}"
