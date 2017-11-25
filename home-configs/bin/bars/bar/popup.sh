#!/bin/bash

kill_popup() {
	#kill $(for pid in $(pidof lemonbar); do
	#      	echo $pid $(ps -p $pid -o etimes=)
	#      done | sort -nr -k2 | awk 'NR > 1 && NR < 7 {print $1}')
	kill $(ps -ef | awk '/song_notify/ && !/awk/ {print $2}')
}

if [[ $(pidof lemonbar | wc -w) -gt 1 ]]; then
	kill_popup
	#kill $(ps -aux | grep popup.sh | awk '/bash.*popup.sh/ && !/awk/ {print $2}' | head -n 1)

	kill $(ps -ef | awk '/bash.*popup.sh/ && !/awk/ {print $2}' | head -n 1)
fi

x=35 

for bar in {1..4}; do
	((x += height))

	case $bar in
		1) display='echo -e "%{c}%{F#999}%{T2}$(~/Desktop/bar/media.sh CONTROLS "$song_info" "$status")%{O40}$volume"' && height=43 && o=7 ;;
		2) display='echo -e "%{O25}%{F#777}$song_info"' && height=12 && o=-3 ;;
		3) display='echo -e "%{O25}%{F#777}$album_info"' && height=12 && o=-3 ;;
		4) display='echo -e "%{c}%{}$(~/Desktop/bar/song_progress.sh 3)"' && height=30 && o=-9 ;;
	esac

	~/Desktop/bar/notification.sh "$display" $height $x $o $bar &
done | wait

sleep 5
kill_popup
