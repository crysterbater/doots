#!/bin/bash
if [[ -z "$@" ]]; then
    find $HOME/bin -type f
else
    bash -c $@
fi

rofi -modi bin:run-from-bin.sh
