#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=" >"

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata title) "
fi

modifier=4
length=${#metadata}
cur=$(($(date +%s%3N)/100))
split=$(($cur/modifier%$length))
scrolled=${metadata:$split}${metadata:0:$split}

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F#7baa14}$icon $scrolled"       # Green when playing
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#8a8a8a}$icon $scrolled"       # Greyed out info when paused
fi
