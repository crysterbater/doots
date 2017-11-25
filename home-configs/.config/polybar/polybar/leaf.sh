#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/polybar/config-leaf vortex &
;polybar -r --config=/home/pringle/.config/polybar/polybar/darkpx bottom &

exit 0
