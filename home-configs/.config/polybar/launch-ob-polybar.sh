#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar
polybar --config=/home/pringle/.config/polybar/polybar/orng/orng-config default &
polybar --config=//home/pringle/.config/polybar/polybar/leaftop/leaftop-config vortex &

echo "Bars launched..."
