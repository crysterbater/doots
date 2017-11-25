#!/bin/bash

path=~/.dotfiles/bar
fifo="$path/main_bar.fifo"

case $1 in
	EXTAND)
		extand="%{B#2b2b2b}%{A:$path/media_controls.sh:}  %{A}%{B#333}"
		echo -e $extand ;;
	SONG)
		song_info=$2
		song_info_index=$3
		time=${song_info##* }
		display_area=30
		delay=3

		if (( ${#song_info} - ${#time} - 3 > $display_area )); then
			song_info=${song_info% *}
			final_index=$((${#song_info} - display_area - 1))
			song_info_index=$((song_info_index % (final_index + 2 * delay)))
			((song_info_index = song_info_index > delay ? song_info_index - delay : 0))
			[[ $song_info_index -gt $final_index ]] && song_info_index=$final_index

			fg="%{F#c2c2c2}"
			ofg="%{F#c2c2c2}"	#ofg="%{F#999}"

			song_info="$fg$ofg ${song_info:$song_info_index:$display_area} $fg"
		fi

		echo -e "%{T1}$song_info" ;;
	PROGRESSBAR)
		progressbar="%{T5}$($path/song_progress.sh)"
		echo -e "$progressbar" ;;
	CONTROLS) 
		[[ "$3" == "playing" && "$2" ]] && toggle_icon=" " || toggle_icon=" "
		[[ "$4" ]] && stop="%{A:mpc stop; echo 'PROGRESSBAR ' > $fifo; echo 'SONG not playing' > $fifo:} %{A}"
		controls="%{T3} %{A:mpc prev:} %{A}%{A:mpc toggle:}$toggle_icon%{A}$stop%{A:mpc next:} %{A}%{O15}"
		echo -e "$controls" ;;
	VOLUME) 
		command="mpc volume +5"
		value=$(mpc volume | sed 's/.*: \([0-9%]*\).*/\1/')
		volume="$($path/volume.sh MEDIA "$command" "$value")"
		echo -e "$volume" ;; 
	BUTTONS)
		player="%{O15}$($path/player_modes.sh)"
		close="%{A:$path/media_controls.sh:} %{A}"
		buttons="$player$close"
		echo -e "$buttons" ;;
esac
