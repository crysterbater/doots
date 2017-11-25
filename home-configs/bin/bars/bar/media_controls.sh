#!/bin/bash

path=~/.dotfiles/bar

command() {
	sed -i "s#\($1=\"\).*\(\".*\)#\1$2\2#" ~/.dotfiles/bar/media.sh
}

if [[ $1 ]]; then
	extand='%{B\#2b2b2b}%{A:$path/media_controls.sh:}  %{A}%{B\#333}'
	progressbar='%{T5}$($path/song_progress.sh)'
	controls="%{T3} %{A:mpc prev:} %{A}%{A:mpc toggle:}\$toggle_icon%{A}\$stop%{A:mpc next:} %{A}%{O15}"
	volume='$($path/volume.sh MEDIA "$command" "$value")'
	player='%{O15}$($path/player_modes.sh)'
	close='%{A:$path/media_controls.sh:} %{A}'
else
	extand='%{B\#2b2b2b}%{A:$path/media_controls.sh ext:}  %{A}%{B\#333}'
fi

command extand "$extand"
command progressbar "$progressbar"
command controls "$controls"
command volume "$volume"
command player "$player"
command close "$close"
