#!/usr/bin/env sh

# Terminate already running instances of the bar
killall -q polybar

# Wait for the processes to shut down
while pgrep -x polybar >/dev/null; do sleep 1; done


# Launch the bar
echo "Launching left bar ..."
polybar left -q &
echo "Done loading left bar."
echo "Launching right bar ..."
polybar right -q &
echo "Done loading right bar."
