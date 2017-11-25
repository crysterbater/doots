#!/bin/bash

case $1 in
	CPU*)
		#cpu_usage=$(top -bn 2 | sed -n '/%Cpu/s/.* \(.*\) us.*/\1%/p' | tail -n 1) ;;
		#echo -e "CPU $cpu_usage" ;;
		top -bn 2 | sed -n '/%Cpu/s/.* \([0-9]*\),. us.*/CPU \1%/p' | tail -n 1 ;;
	RAM*)
		calculate() {
			/usr/bin/printf "%.0f" `bc <<< "scale=1; $1 / $2"`
		}

		draw() {
			for l in $(seq $2); do
				eval $1+=$3
			done
		}

		total_ram=$(free -m | awk 'NR==2 {print $2}')
		used_ram=$(free -m | awk 'NR==3 {print $3}')
		step_percentage=$(calculate $total_ram 100)
		used_percentage=$(calculate $used_ram $step_percentage)

		echo -e "RAM ${used_percentage}%" ;;
	DISK*)
		disk_usage="%{F#a9a9a9}"

		command() {
			command="%{A:if ! wmctrl -a '$1'; then thunar $2; fi:}%{A3:gksudo umount $2:} %{A}%{A}"
		}

		while read -r line; do
			read dev free space <<< "$(echo $line)"

			[[ ${space%*%} -gt 97 || $free =~ G ]] && space="%{F#A6875B}$free%{F#a9a9a9}"

			case ${dev##*/} in
				sda1*) dev=${dev##*/} && command 'sola - File Manager' /home/sola ;;
				sda5*) dev=${dev##*/} && command '61_GB' /media/sola/61_GB ;;
				sda6*) dev=${dev##*/} && command '9.8_GB' /media/sola/9.8_GB ;;
			esac

			disk_usage+="%{T6}$command$dev %{T6}$space%{T-}%{O20}"
		done <<< "$(df -h | awk '/sda/ {print $1" "$4" "$5}')"

		echo -e "$disk_usage%{T-}" ;;
	MOUNT*)
		#mount="$(~/Desktop/bar/mount_drives.sh)"

		echo -e "$mount" ;;
esac
