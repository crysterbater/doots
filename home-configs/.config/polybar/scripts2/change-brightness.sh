#! /bin/bash
# Change system brightness using light
case $1 in
    "raise")
        light -A 5
        ;;
    "lower")
        light -U 5
        ;;
esac
