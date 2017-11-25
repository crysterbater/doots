#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/polybar/foolz.config example &
;polybar -r --config=/home/pringle/.config/polybar/polybar/darkpx bottom &

exit 0
