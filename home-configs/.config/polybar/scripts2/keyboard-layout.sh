#! /bin/bash
# Retrieve current keyboard layout
layout=`setxkbmap -query | grep layout | cut -d ' ' -f 6`
variant=`setxkbmap -query | grep variant | cut -d ' ' -f 5`
if [ $variant ]; then
    echo "${layout^^}-${variant^}"
else
    echo "${layout^^}"
fi

