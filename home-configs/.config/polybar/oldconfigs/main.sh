#!/bin/bash

pkill polybar
polybar --config=/home/pringle/.config/polybar/oldconfigs/busy-config &
;polybar --config=//home/pringle/.config/polybar/polybar/leaftop/leaftop-config vortex &

exit 0
