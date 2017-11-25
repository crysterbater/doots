#!/usr/bin/env bash

monitor_main="DP-1"
monitor_two=

# Find which second display is connected and set the variable
# DVI could be plugged into one of the two GPU ports so the extra condition is added

if [[ xrandr -q | grep -q "HDMI-0\ conn" ]]; then
  $monitor_two="HDMI-0"
fi

if [[ xrandr -q | grep -q "DVI-D-0\ conn" ]]; then
  $monitor_two="DVI-D-0"
fi

if [[ xrandr -q | grep -q "DVI-I-1\ conn" ]]; then
  $monitor_two="DVI-I-1"
fi

# Configure xrandr,
# Only configure the second monitor if it is set 

if [[ ! -z "$monitor_two" ]]; then
  xrandr --output $monitor_main --mode 2560x1440 --output $monitor_two --mode 1680x1050 --left-of $monitor_main
fi
