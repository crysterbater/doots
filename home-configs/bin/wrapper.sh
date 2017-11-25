#!/bin/bash

# NOTE: some of this might not work correctly either because i've misunderstood the script you gave me, or because i made a mistake 

# I did this in bash, but you can change it if you want.

# list all the files, and force them all to be on one line using tr.
files=$(find ~/.i3 -name config* -type f | tr "\n" "|")

# When rofi is run in dmenu mode, the users choice is outputted in stdout, so we can use this in the next part without any edits.
choice=$(echo "$files" | rofi -sep '|' -dmenu -p "Select a file:")

# Do the copying thing you had in your script. I think i understand what you wanted to do here, but i'm not sure it'll work how you want.
cp $choice ~/.i3/config


