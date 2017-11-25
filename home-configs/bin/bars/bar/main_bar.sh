#!/bin/bash

fifo="/home/sola/Desktop/main_fifo"
#separator="%{B#00000000}%{O10}%{B#404040}"
separator="%{B#00000000}%{O10}%{B#404040}"

get_workspaces() {
	echo -e "WORKSPACES $(/home/pringle/bin/bars/bar/workspaces_parted.sh)"
}

get_mail() {
	echo -e "MAIL $(/home/pringle/bin/bars/bar/system_info.sh MAIL)"
}

get_volume() {
	echo -e "VOLUME $(/home/pringle/bin/bars/bar/system_info.sh VOLUME)"
}

get_network() {
	echo -e "NETWORK $(~/Desktop/bar/system_info.sh NETWORK)"
}

get_date() {
	echo -e "DATE $(/home/pringle/bin/bars/bar/system_info.sh DATE)"
}

shut_down="$(/home/pringle/bin/bars/bar/system_info.sh SHUT_DOWN)"

while true; do get_workspaces; sleep 1; done > "$fifo" &
while true; do get_mail; sleep 10; done > "$fifo" &
while true; do get_volume; sleep 1; done > "$fifo" &
while true; do get_network; sleep 100; done > "$fifo" &
while true; do get_date; sleep 60; done > "$fifo" &

while read -r line; do
	case $line in
		WORKSPACES*) workspaces="${line:11}" ;;
		MAIL*) mail="${line:5}" ;;
		VOLUME*) volume="${line:7}" ;;
		NETWORK*) network="${line:8}" ;;
		DATE*) date="${line:5}";;
	esac

	echo -e "$separator%{F#999}%{T1}$workspaces$separator%{T4}$mail$separator$volume$separator$date$separator$shut_down%{B$1}"
done < "$fifo" | lemonbar -p -B$1 -f "$2" -o 0 -f "$3" -o -1 -f "$4" -o -0 -f "$5" -o 0 -a 70 -u 2 -g x22+$6+10 -n main_bar | bash
