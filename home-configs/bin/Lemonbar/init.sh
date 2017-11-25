#!/bin/zsh

DIRNAME=$(dirname $0)

cd "$DIRNAME"

source "/home/pringle/bin/lamb/config.sh"
FIFO="$PANEL_FIFO_PATH"

if [ $(pgrep -cf "lemonbar -n panel") -gt 1 ] ; then
  printf "%s\n" "The top panel is already running." >&2
  exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "$FIFO" ] && rm "$FIFO"
mkfifo "$FIFO"


#
# Events
#

# Pulse audio
pactl subscribe | zsh /home/pringle/bin/Lemonbar/scripts/pactl_parse.sh > "$FIFO" &

# MPD
mpc idleloop > "$FIFO" &

# System information
conky -c ./conky | zsh /home/pringle/bin/Lemonbar/conky_parser.sh > "$FIFO" &

#
# Kickstarts
# Otherwise event-driven sections won't display anything until an event is triggered
#

# Kickstart volume
echo "V$(zsh /home/pringle/bin/Lemonbar/scripts/volume.sh)" > "$FIFO" &

# Kickstart player
echo "p" > "$FIFO" &

# Kickstart backlight
echo "L" > "$FIFO" &


#
# Timers
#

# Time
while true; do
  echo "T" > "$FIFO"
  echo "K" > "$FIFO"
  sleep 1s
done &

# Battery
while true; do
  echo "B$(zsh /home/pringle/bin/Lemonbar/scripts/network.sh)" > "$FIFO"
  echo "L" > "$FIFO"
  sleep 10s
done &

# Network
while true; do
  echo "N$(zsh /home/pringle/bin/Lemonbar/scripts/network.sh)" > "$FIFO"
  sleep 10s
done &

#
# Lemonbar
#

cat "$FIFO" \
  | zsh /home/pringle/bin/Lemonbar/fifo_parser.sh \
  | lemonbar -n panel -p -a 36 -g "x$PANEL_HEIGHT" -f "$PANEL_FONT" -f "$PANEL_ICON_FONT0" -f "$PANEL_ICON_FONT1" -u 4 \
  | bash

wait
