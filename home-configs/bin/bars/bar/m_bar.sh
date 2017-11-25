#!/bin/bash

fifo="/home/sola/Desktop/media_fifo"
separator="%{B#00000000}%{O15}%{B#404040}"


while true; do
	status=$(mpc | sed -n 's/.*\[\(.*\)\].*/\1/p')
	if [[ "$status" == 'playing' ]]; then
		time=$(mpc | awk 'NR == 2 {print $3}') && elapsed_time=${time%/*}
		song_info="$(mpc current -f "%artist% - %title%   $time")"
		[[ ${elapsed_time%:*} -eq 0 && ${elapsed_time#*:} =~ 0[0-5] ]] && song_info_index=0 || ((song_info_index++))

		echo -e "SONG $(/home/pringle/bin/bars/bar/media.sh "$song_info" $song_info_index)" 
	fi

	echo -e "EXTAND $(/home/pringle/bin/bars/bar/media.sh EXTAND)"
	echo -e "MEDIA_VOLUME $(/home/pringle/bin/bars/bar/media.sh VOLUME)"
	echo -e "CONTROLS $(/home/pringle/bin/bars/bar/media.sh CONTROLS "$song_info" "$status" stop)"

	sleep 1
done > "$fifo" &
#
#get_workspaces() {
#	~/Desktop/bar/workspaces_parted.sh
#}
#
#get_mail() {
#	echo -e "MAIL $(~/Desktop/bar/system_info.sh MAIL)"
#}
#
#get_volume() {
#	echo -e "VOLUME $(~/Desktop/bar/system_info.sh VOLUME)"
#}
#
#get_network() {
#	echo -e "NETWORK $(~/Desktop/bar/system_info.sh NETWORK)"
#}
#
#get_date() {
#	echo -e "DATE $(~/Desktop/bar/system_info.sh DATE)"
#}

#while true; do get_taskbar; sleep 1; done &
#while true; do get_song_info; sleep 1; done &
#while true; do get_workspaces; sleep 1; done &
#while true; do get_mail; sleep 10; done > "$fifo" &
#while true; do get_volume; sleep 1; done > "$fifo" &
#while true; do get_network; sleep 100; done > "$fifo" &
#while true; do get_date; sleep 60; done > "$fifo" &
#while true; do get_mount; sleep 1; done > "$fifo" &
#while true; do get_disk; sleep 10; done > "$fifo" &
#while true; do get_cpu; sleep 3; done > "$fifo" &
#while true; do get_ram; sleep 3; done > "$fifo" &


while read -r line; do
	case $line in
		#TASKBAR*) taskbar="${line:8}" ;;
		SONG*) song_info="${line:5}" ;;
		EXTAND*) extand=${line:7} ;;
		CONTROLS*) controls="${line:9}" ;;
		MEDIA_VOLUME*) media_volume="${line:13}" ;;
		#WORKSPACES*) workspaces="${line:11}" ;;
		#MAIL*) mail="${line:5}" ;;
		#VOLUME*) volume="${line:7}" ;;
		#NETWORK*) network="${line:8}" ;;
		#DATE*) date="${line:5}";;
		#SHUT_DOWN*) shut_down="${line:10}"
	esac

	echo -e "%{r}%{B#444}%{O20}$extand %{T5}%{F#999}$controls%{T1}%{F#ccc}$song_info %{F#999}%{T4}$media_volume%{O20}%{B$1}"
	#echo -e "$separator%{F#999}%{T1}$workspaces$separator%{T4}$mail$separator$volume$separator$date%{B$1}"

done < "$fifo" | lemonbar -p -B"$1" -f "$2" -o 1 -f "$3" -o -1 -f "$4" -o -2 -f "$5" -o 1 -f "$6" -o -1 -a 50 -g $7x22+0+10 -n media_bar | bash
