#!/bin/bash

path=~/.dotfiles/bar

fifo="/home/sola/.dotfiles/bar/main_bar.fifo"

bg="%{B#404040}"	#575e66 	353738
media_bg="%{B#333}"
media_ending="$bg%{F#333}%{T6}%{F#999}"

song_info="not playing"

get_media() {
	status=$(mpc | sed -n 's/.*\[\(.*\)\].*/\1/p')
	if [[ "$status" == 'playing' ]]; then
		time=$(mpc | awk 'NR == 2 {print $3}') && elapsed_time=${time%/*}
		song_info="$(mpc current -f "%artist% - %title%  $time")"
		[[ ${elapsed_time%:*} -eq 0 && ${elapsed_time#*:} =~ 0[0-5] ]] && song_info_index=0 || ((song_info_index++))

		echo -e "PROGRESSBAR $($path/media.sh PROGRESSBAR)"
		echo -e "SONG $($path/media.sh SONG "$song_info" $song_info_index)" 
	fi

	echo -e "EXTAND $($path/media.sh EXTAND)" 
	echo -e "MEDIA_VOLUME $($path/media.sh VOLUME)" 
	echo -e "CONTROLS $($path/media.sh CONTROLS "$song_info" "$status" stop)" 
}

get_workspaces() {
	echo -e "WORKSPACES $($path/workspaces_doted.sh)"
}

get_mail() {
	echo -e "MAIL $($path/system_info.sh MAIL)"
}

get_volume() {
	echo -e "VOLUME $($path/system_info.sh VOLUME)"
}

get_network() {
	echo -e "NETWORK $($path/system_info.sh NETWORK)"
}

get_date() {
	echo -e "DATE $($path/system_info.sh DATE)"
}

get_term() {
	echo -e "TERM $($path/system_info.sh TERM)"
}

shut_down="$($path/system_info.sh SHUT_DOWN)"

while true; do get_media; sleep 1; done > "$fifo" &
while true; do get_workspaces; sleep 1; done > "$fifo" &
while true; do get_mail; sleep 10; done > "$fifo" &
while true; do get_volume; sleep 1; done > "$fifo" &
while true; do get_network; sleep 100; done > "$fifo" &
while true; do get_date; sleep 60; done > "$fifo" &
while true; do get_term; sleep 1; done > "$fifo" &

while read -r line; do
	case $line in
		EXTAND*) extand=${line:7} ;;
		SONG*) song_info="${line:5}" ;;
		CONTROLS*) controls="${line:9}" ;;
		PROGRESSBAR*) progressbar="${line:12}" ;;
		MEDIA_VOLUME*) media_volume="${line:13}" ;;
		WORKSPACES*) workspaces="${line:11}" ;;
		MAIL*) mail="${line:5}" ;;
		VOLUME*) volume="${line:7}" ;;
		NETWORK*) network="${line:8}" ;;
		DATE*) date="${line:5}";;
		TERM*) term=${line:5}
	esac

	media="%{l}%{B#333}$extand $progressbar %{F#999}$controls%{F#ccc}$song_info %{F#999}%{T4}$media_volume $media_ending"
	system="%{c}$workspaces%{T4}%{r}$term%{O20}$mail%{O10}$volume%{O10}$date%{O10}$shut_down"

	echo -e "$media $system"
done < "$fifo" | lemonbar -p -B$1 -f "$2" -o -3 -f "$3" -o -3 -f "$4" -o -4 -f "$5" -o -2 -f "$6" -o -3 -f "$7" -o 0 -a 70 -u 2 -g x21 -n main_bar | bash
