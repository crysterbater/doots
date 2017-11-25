#!/bin/sh
sed -i \
         -e 's/#191a29/rgb(0%,0%,0%)/g' \
         -e 's/#eeeeec/rgb(100%,100%,100%)/g' \
    -e 's/#26273d/rgb(50%,0%,0%)/g' \
     -e 's/#14b2de/rgb(0%,50%,0%)/g' \
     -e 's/#26273d/rgb(50%,0%,50%)/g' \
     -e 's/#eeeeec/rgb(0%,0%,50%)/g' \
	$@
