#! /bin/sh
#========================================#
#     Caligula's wal recycle script.     #
#========================================#

# Cycle wal background image and colorscheme.
wal -i "/home/pringle/Pictures/wal"

# Restart polybar to match new colorscheme.
pkill polybar
polybar top &
polybar bottom &


