#!/bin/sh
sed -i \
         -e 's/#21252c/rgb(0%,0%,0%)/g' \
         -e 's/#ffffff/rgb(100%,100%,100%)/g' \
    -e 's/#1c2429/rgb(50%,0%,0%)/g' \
     -e 's/#1fbab8/rgb(0%,50%,0%)/g' \
     -e 's/#2b2a2f/rgb(50%,0%,50%)/g' \
     -e 's/#ffffff/rgb(0%,0%,50%)/g' \
	$@
