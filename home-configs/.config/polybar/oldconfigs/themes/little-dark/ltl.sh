#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/oldconfigs/themes/little-dark/config main &
;polybar --config=/home/pringle/.config/polybar/oldconfigs/config bottom &

exit 0
