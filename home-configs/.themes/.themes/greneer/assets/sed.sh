#!/bin/sh
sed -i \
         -e 's/#1A2024/rgb(0%,0%,0%)/g' \
         -e 's/#A7CEC8/rgb(100%,100%,100%)/g' \
    -e 's/#0e0e0e/rgb(50%,0%,0%)/g' \
     -e 's/#37bf8d/rgb(0%,50%,0%)/g' \
     -e 's/#1a1a1a/rgb(50%,0%,50%)/g' \
     -e 's/#fff/rgb(0%,0%,50%)/g' \
	$@
