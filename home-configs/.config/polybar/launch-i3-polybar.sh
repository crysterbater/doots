#!/usr/bin/env bash

pkill polybar
polybar -r --config=$HOME/.config/polybar/config-i3 bar1 &
polybar -r --config=$HOME/.config/polybar/config-i3 bar2 &

exit 0
