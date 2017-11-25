#! /bin/bash
# Capture both stderr and stdout
status=$(playerctl status 2>&1)
if [[ "$status" == "Playing" ]]; then
    title=`exec playerctl metadata xesam:title`
    artist=`exec playerctl metadata xesam:artist`
    echo "$title | $artist"
else
    echo ""
fi
