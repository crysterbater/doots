#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/oldconfigs/misc.config left &
polybar -r --config=/home/pringle/.config/polybar/oldconfigs/misc.config right &

exit 0
