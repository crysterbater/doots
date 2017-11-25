#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/oldconfigs/cyberpunk.config future &
;polybar --config=/home/pringle/.config/polybar/oldconfigs/config bottom &

exit 0
