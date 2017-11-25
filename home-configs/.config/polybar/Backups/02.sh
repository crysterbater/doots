#!/bin/bash

pkill polybar
polybar -r --config=/home/pringle/.config/polybar/Backups/misc02.config example &
;polybar --config=/home/pringle/.config/polybar/oldconfigs/config bottom &

exit 0
