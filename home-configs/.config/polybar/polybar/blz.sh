#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/polybar/blazing-config blazing &
;polybar --config=//home/pringle/.config/polybar/polybar/leaftop/leaftop-config vortex &

exit 0
