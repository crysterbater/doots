#! /bin/bash
current=`$HOME/.config/polybar/keyboard-layout.sh`

case $current in
    "US")
        setxkbmap -layout us -variant intl
        ;;
    "US-Intl")
        setxkbmap -layout us
        ;;
esac
