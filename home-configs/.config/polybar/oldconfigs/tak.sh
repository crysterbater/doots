#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/oldconfigs/tak.config takmobar &
;polybar --config=/home/pringle/.config/polybar/oldconfigs/config bottom &

exit 0
