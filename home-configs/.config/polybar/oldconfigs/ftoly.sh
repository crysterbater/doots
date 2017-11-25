#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/oldconfigs/ftoly.config momiji &
;polybar --config=/home/pringle/.config/polybar/oldconfigs/config bottom &

exit 0
