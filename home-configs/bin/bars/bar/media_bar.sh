#!/bin/bash

fifo="/home/sola/Desktop/media_fifo"
bg="%{B#404040}"	#575e66

while true; do
	status=$(mpc | sed -n 's/.*\[\(.*\)\].*/\1/p')
	if [[ "$status" == 'playing' ]]; then
		time=$(mpc | awk 'NR == 2 {print $3}') && elapsed_time=${time%/*}
		song_info="$(mpc current -f "%artist% - %title%  $time")"
		[[ ${elapsed_time%:*} -eq 0 && ${elapsed_time#*:} =~ 0[0-5] ]] && song_info_index=0 || ((song_info_index++))

		echo -e "PROGRESSBAR $(/home/pringle/bin/bars/bar/media.sh PROGRESSBAR)"
		echo -e "SONG $(/home/pringle/bin/bars/bar/media.sh SONG "$song_info" $song_info_index)"
	fi

	echo -e "EXTAND $(/home/pringle/bin/bars/bar/media.sh EXTAND)"
	echo -e "MEDIA_VOLUME $(/home/pringle/bin/bars/bar/media.sh VOLUME)" 
	echo -e "CONTROLS $(/home/pringle/bin/bars/bar/media.sh CONTROLS "$song_info" "$status" stop)"

	sleep 1
done > "$fifo" &

while read -r line; do
	case $line in
		EXTAND*) extand=${line:7} ;;
		SONG*) song_info="${line:5}" ;;
		CONTROLS*) controls="${line:9}" ;;
		PROGRESSBAR*) progressbar="${line:12}" ;;
		MEDIA_VOLUME*) media_volume="${line:13}" ;;
	esac
	echo -e "%{r}$bg%{O20}$extand $progressbar %{F#999}$controls%{F#ccc}$song_info %{F#999}%{T4}$media_volume%{O20}%{B$1}"
done < "$fifo" | lemonbar -p -B"$1" -f "$2" -o 0 -f "$3" -o -1 -f "$4" -o -1 -f "$5" -o 0 -f "$6" -o 0 -a 50 -g $7x22+0+10 -n media_bar | bash
