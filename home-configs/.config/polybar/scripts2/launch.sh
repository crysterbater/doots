#! /bin/bash
# Terminate current polybars
killall -q polybar

# Wait until they have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch polybar
polybar top &
