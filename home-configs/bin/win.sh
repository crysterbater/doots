#!/bin/bash

WINID=$(xdotool search --class tint2)

# exit if tint2 not running
(( $? > 0 )) && exit 1

# toggle window mapped state
if xdotool search --onlyvisible --class tint2 > /dev/null ; then
    xdotool windowunmap $WINID
else
    xdotool windowmap $WINID
fi
