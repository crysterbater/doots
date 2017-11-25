#! /bin/bash
# Get current backlight percentage
brightness=`light -G | cut -d '.' -f 1`
echo "$brightness%"
