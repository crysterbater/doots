#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/oldconfigs/themes/jlervins/config base &
;polybar --config=/home/pringle/.config/polybar/oldconfigs/config bottom &

exit 0
