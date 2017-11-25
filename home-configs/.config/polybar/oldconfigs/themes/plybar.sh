#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/oldconfigs/themes/cwhat.onfig daike-top &
;polybar --config=/home/pringle/.config/polybar/oldconfigs/config bottom &

exit 0
