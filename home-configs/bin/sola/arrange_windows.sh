#!/bin/bash

#propertie file
p_file=~/Documents/original_properties.txt 
window_id=$(printf 0x%x $(xdotool getactivewindow))

case $# in
	0) 

		function set_properties() {
			window=${awp[$1]}
			id=${window%% *}
			properties=( ${window#* } )
		}

		#current_window_properties
		cwp=( $(wmctrl -l -G | awk '$1 ~ "'${window_id#0x}'" {print $3 - 2 " " $4 - 20 " " $5 " " $6}') )
		current_desktop=$(xdotool get_desktop)
		x_offset=30

		for resolution in $(xrandr -q | awk -F '[+, ]' '/ connected/ {print $3}'); do
			display_width=${resolution%x*}
			display_height=${resolution#*x}

			((max_point += display_width))

			if ((min_point + display_width <= ${cwp[0]})); then
				((min_point += display_width))
			else
				min_point=$x_offset
				break
			fi
		done

		while read -r line; do
			#all_windows_properties
			awp+=("$line")
		done <<< "$(wmctrl -l -G | awk '$2 == '$current_desktop' &&
			$6 > '$display_height' - 100 &&
			$5 < '$display_width' &&
			$3 > '$min_point' {print $1 " " $3 - 2 " " $4 " " $5 " " $6}' | sort -nk 2)"

		last_index=$((${#awp[*]} - 1))

		if [[ ${awp[*]} ]]; then
			for i in $(seq 0 $last_index); do
				set_properties $i

				[[ $id =~ ${window_id#0x} ]] && currrent=$i

				if [[ ${properties[0]} == $min_point ]]; then
					[[ ! $currrent ]] && ((min_point += (${properties[2]} + x_offset)))
				else
					breakage=true
					index=$i
					break
				fi
			done
		fi


		if [[ $breakage ]]; then
			max_point=${properties[0]}

			[[ $currrent == $index ]] && ((max_point += (${properties[2]} + x_offset)))
		else
			if [[ ! $currrent && ${properties[2]} > $((max_point - (3 * x_offset))) ]]; then
				properties[2]=$((${properties[2]} / 2 - (x_offset / 2)))
				min_point=$((${properties[2]} + (2 * x_offset)))

				wmctrl -ir $id -e 0,${properties[0]},50,${properties[2]},${properties[3]}
			fi
		fi

		[[ ! $(grep $window_id $p_file 2> /dev/null) ]] && echo "wmctrl -ir $window_id  -e 0,${cwp[0]},${cwp[1]},${cwp[2]},${cwp[3]}" >> $p_file

		wmctrl -ir $window_id -e 0,$min_point,50,$((max_point - (min_point + x_offset))),$((display_height - 80))
		;;
	1)
		[[ -f $p_file ]] && command=$(grep $window_id $p_file)

		if [[ $command ]]; then
			sed -i "/$window_id/d" $p_file
			[[ ! -s $p_file ]] && rm $p_file
			$command
		fi
		;;
	*)
		~/.dotfiles/scripts/move_window.sh $@
esac
