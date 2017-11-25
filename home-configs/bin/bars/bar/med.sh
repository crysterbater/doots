#!/bin/bash

fifo="/home/sola/Desktop/media_fifo"
sep="%{B#00000000}%{O15}%{B#404040}"

while true; do
	status=$(mpc | sed -n 's/.*\[\(.*\)\].*/\1/p')
	if [[ "$status" == 'playing' ]]; then
		time=$(mpc | awk 'NR == 2 {print $3}') && elapsed_time=${time%/*}
		song_info="$(mpc current -f "%artist% - %title%   $time")"
		[[ ${elapsed_time%:*} -eq 0 && ${elapsed_time#*:} =~ 0[0-5] ]] && song_info_index=0 || ((song_info_index++))

		~/Desktop/bar/media.sh SONG "$song_info" $song_info_index
	fi

	~/Desktop/bar/media.sh EXTAND
	~/Desktop/bar/media.sh VOLUME
	~/Desktop/bar/media.sh CONTROLS "$song_info" "$status" stop

	sleep 1
done & 

while read -r line; do
	case $line in
		SONG*) song_info="${line:5}" ;;
		EXTAND*) extand=${line:7} ;;
		CONTROLS*) controls="${line:9}" ;;
		MEDIA_VOLUME*) media_volume="${line:13}" ;;
	esac

	echo -e "%{r}%{B#444}%{O20}$extand %{T5}%{F#999}$controls%{T1}%{F#ccc}$song_info %{F#999}%{T4}$media_volume%{O20}"
done < "$fifo" | lemonbar -p -B"$1" -f "$2" -o 1 -f "$3" -o -1 -f "$4" -o -2 -f "$5" -o 1 -f "$6" -o -1 -a 50 -g $7x22+0+10 -n media_bar | bash
