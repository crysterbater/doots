#!/bin/bash

# jump_remember.sh
# ---------------------------
# desc:
#  Remembers a window or jumps to a remembered window.
#
# usage:
#  $ jump_remember.sh       <-- remembers a window
#  $ jump_remember.sh -jump <-- jump to a remembered window
#
# setup as C-0 for jump, C-S-0 for remembering in openbox.

remember_file=~/tmp/window_remembering

if [ "$1" = "-jump" ]
then
    id=$(cat $remember_file)
    echo $id
    wmctrl -i -a "$id"
else
    echo "select the window to remember"

    id=$(xwininfo | grep "Window id" | cut -d " " -f4)
    echo $id
    echo $id > $remember_file
fi
