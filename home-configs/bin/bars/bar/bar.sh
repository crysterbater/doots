#!/bin/bash

fifo="/home/sola/Desktop/fifo"

bg='d5404959'	# solid background e55A6373
solid_bg='e55A6373'
solid_bg='525252'

font1="Fira Code:size=10"
font2="IcoMoon:size=10"
font3="FontAwesome:size=9"
font4="Hack:size=14"
font5="Fira Code:size=9"
font6="consolas:size=10:weight=heavy"
font7="consolas:size=10:weight=heavy"

#media_beggining="%{B#00000000}%{F#333333}%{B#333333}"
#media_ending="%{B#aa404040}%{F#333}%{T4}%{F#cecece}"
#
#usage_beggining="%{F#3e3e3e}%{B#3e3e3e}%{F#cecece}"
#usage_ending="%{B#333333}%{F#3e3e3e}%{F#cecece}"
#
#system_info_beggining="%{F#333}%{B#333}%{F#cecece}%{T1}"
#system_info_ending="%{B#00000000}%{F#333}%{B#d9545454}"

song_info_index=0
song_info="not playing"

get_song_info() {
	status=$(mpc | sed -n 's/.*\[\(.*\)\].*/\1/p')
	if [[ "$status" == 'playing' ]]; then
		time=$(mpc | awk 'NR == 2 {print $3}') && elapsed_time=${time%/*}
		song_info="$(mpc current -f "%artist% - %title%   $time")"
		[[ ${elapsed_time%:*} -eq 0 && ${elapsed_time#*:} =~ 0[0-5] ]] && song_info_index=0 || ((song_info_index++))

		#echo -e "PROGRESSBAR $(~/Desktop/bar/song_progress.sh)"
		echo -e "PROGRESSBAR $(/home/pringle/bin/bars/bar/media.sh PROGRESSBAR)"
		echo "SONG $(/home/pringle/bin/bars/bar/media.sh SONG "$song_info" $song_info_index)"
		#$(~/Desktop/bar/media.sh SONG "$song_info" $song_info_index)
	fi

	echo -e "EXTAND $(/home/pringle/bin/bars/bar/media.sh EXTAND)"
	#$(~/Desktop/bar/media.sh EXTAND)
	echo -e "MEDIA_VOLUME $(/home/pringle/bin/bars/bar/media.sh VOLUME)"
	#$(~/Desktop/bar/media.sh VOLUME)
	echo -e "CONTROLS $(/home/pringle/bin/bars/bar/media.sh CONTROLS "$song_info" "$status" stop)"
	#$(~/Desktop/bar/media.sh CONTROLS "$song_info" "$status" stop)
}

#workspace_count=$(wmctrl -d | wc -l)
current_workspace=$(xdotool get_desktop)

get_workspaces() {
	echo -e "WORKSPACES $(/home/pringle/bin/bars/bar/workspaces_parted.sh $current_workspace)"
}

get_mail() {
	echo -e "MAIL $(/home/pringle/bin/bars/bar/system_info.sh MAIL)"
}

get_volume() {
	echo -e "VOLUME $(~/Desktop/bar/system_info.sh VOLUME)"
}

get_network() {
	echo -e "NETWORK $(~/Desktop/bar/system_info.sh NETWORK)"
}

get_date() {
	echo -e "DATE $(~/Desktop/bar/system_info.sh DATE)"
}

get_mount() {
	echo -e "MOUNT $(~/Desktop/bar/usage.sh MOUNT)"
}

get_disk() {
	echo -e "DISK $(~/Desktop/bar/usage.sh DISK)"
}

get_ram() {
	echo -e "RAM $(~/Desktop/bar/usage.sh RAM)"
}

get_cpu() {
	echo -e "CPU $(~/Desktop/bar/usage.sh CPU)"
}

shut_down() {
	echo -e "SHUT_DOWN $(~/Desktop/bar/system_info.sh SHUT_DOWN)" > "$fifo" &
}

while true; do get_song_info; sleep 1; done > "$fifo" &
while true; do get_workspaces; sleep 1; done > "$fifo" &
while true; do get_mail; sleep 10; done > "$fifo" &
while true; do get_volume; sleep 1; done > "$fifo" &
while true; do get_network; sleep 100; done > "$fifo" &
while true; do get_date; sleep 60; done > "$fifo" &
while true; do get_mount; sleep 1; done > "$fifo" &
while true; do get_disk; sleep 10; done > "$fifo" &
while true; do get_cpu; sleep 3; done > "$fifo" &
while true; do get_ram; sleep 3; done > "$fifo" &

shut_down

while read -r line; do
	case $line in
		SONG*) song_info="${line:5}" ;;
		PROGRESSBAR*) progressbar="${line:12}" ;;
		EXTAND*) extand=${line:7} ;;
		CONTROLS*) controls="${line:9}" ;;
		MEDIA_VOLUME*) media_volume="${line:13}" ;;
		BUTTONS*) buttons="${line:7}" ;;
		WORKSPACES*) workspaces="${line:11}" ;;
		MOUNT*) mount="${line:6}" ;;
		DISK*) disk="${line:5}" ;;
		CPU*) cpu="${line:4}" ;;
		RAM*) ram="${line:4}" ;;
		MAIL*) mail="${line:5}" ;;
		VOLUME*) volume="${line:7}" ;;
		NETWORK*) network="${line:8}" ;;
		DATE*) date="${line:5}";;
		SHUT_DOWN*) shut_down="${line:10}"
	esac

	media="$extand $progressbar %{F#999}$controls%{T1}$song_info %{F#c2c2c2}%{T6}$media_volume$media_ending"
	workspaces="%{c}%{F#777}$workspaces"
	#usage="$usage_beggining %{T6}$mount $disk%{O5}%{T6}$cpu%{O20}$ram%{F#c2c2c2}%{O7}"
	system_info="%{r}$usage$system_info_beggining $mail%{T6}$volume$date"
	echo -e "$media $workspaces$system_info $shut_down%{B#$solid_bg}"
done < "$fifo" | lemonbar -p -B#3e3e3e -f "$font1" -o -2 \
				    -f "$font2" -o -4 \
				    -f "$font3" -o -5 \
				    -f "$font4" -o -0 \
				    -f "$font5" -o -4 \
				    -f "$font6" -o -2 \
				    -f "$font7" -o -3 -a 55 -u 2 -g x22 | bash
