#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
# MONITOR=eDP1 polybar top &
# TODO: Add for 2nd display as well by getting display name using xrandr --version
# MONITOR=DP-1-1 polybar top &
MONITOR=eDP1 polybar bottom &

echo "Bars launched..."
