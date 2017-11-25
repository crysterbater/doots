#!/bin/bash

command() {
	echo "sed -i 's/\(mount=.*\)$1\().*\)/\1$2\2/' ~/Desktop/bar/usage.sh"
}

if [[ $1 ]]; then
	for dev in $(ls /media/vlada); do
		[[ $(mount | grep $dev) ]] && color='%{F#a9a9a9}' || color="%{F#656565}"
		mount="~/Documents/scripts/drives/sh/mount_new.sh $dev" && umount="gksudo umount /media/vlada/$dev"
		drives+="$color%{A:$mount:}%{A3:$umount:} %{A}%{A}$dev%{O20}"
	done

	echo -e "$drives%{A:$(command ' .*' ''):} %{A}"
else
	echo -e "%{A:$(command '' ' drives'):}%{F#a9a9a9} %{A}"
fi
