#!/bin/bash

if [[ -z $@ ]]; then
	echo -e "drop terminal\nterminal\nvim\nncmpcpp\nncmpcpp vertical\nncmpcpp vertical visualizer"
else
	command=$@

	killall rofi
	case $command in
		drop*) ~/.dotfiles/scripts/toggle_drop_down.sh ;;
		bring*) wmctrl -a DROPDOWN ;;
		terminal) xfce4-terminal ;;
		vim) xfce4-terminal -e nvim ;;
		ncmpcpp) xfce4-terminal -e ncmpcpp ;;
		*vertical) ~/Desktop/bar/player.sh OPEN VERT ;;
		*visualizer) ~/Desktop/bar/player.sh OPEN VERT BOTTOM ;;
	esac
fi
