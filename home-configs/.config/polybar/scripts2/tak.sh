#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/scripts2/config top &
;polybar --config=/home/pringle/.config/polybar/oldconfigs/config bottom &

exit 0
