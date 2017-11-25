#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1
polybar main -c /home/pringle/.config/polybar/oldconfigs/themes/jlervins/config base

