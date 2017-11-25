#!/bin/bash

path=~/.dotfiles/bar

bottom=""
[ $(tmux list-panes -t music:0 -F '#F' | grep Z | wc -l) -gt 0 ] && set_zoom="resizep -t music:0 -Z \;"

case $1 in
	OPEN*)
		if ! wmctrl -a music; then
			$path/ncmpcpp_control.sh $3

			sed -i "s/\(bottom=\"\).*\(\"\)/\1$3\2/" ~/Desktop/bar/player.sh

			[ $3 ] && order="ncmpcpp \; splitw -p 15 ncmpcpp -c ~/.ncmpcpp/config_visualizer \; selectp -U" || \
				    order="ncmpcpp -c ~/.ncmpcpp/config_visualizer \; splitw -p 85 ncmpcpp"

			if [[ $2 =~ VERT ]]; then
				xfce4-terminal --geometry=60x45 -T music -e "tmux new -A -s music $order" &
			else
				xfce4-terminal -T music -e ncmpcpp &
			fi
		fi ;;
	VIS*) eval "/usr/bin/tmux $set_zoom resizep -t music:0.0 -Z \; send 8" ;;
	LIST*) eval "/usr/bin/tmux $set_zoom resizep -t music:0.1 -Z \; send 1" ;;
	DEFAULT*)
		if [ "$bottom" ]; then
			list_pane=0 && vis_pane=1
		else
			list_pane=1 && vis_pane=0
		fi

		eval "/usr/bin/tmux $set_zoom send -t music:0.$list_pane 1 \; send -t music:0.$vis_pane 8 \; selectp -t music:0.$list_pane" ;;
esac
