#!/bin/sh
sed -i \
         -e 's/#21252b/rgb(0%,0%,0%)/g' \
         -e 's/#ffffff/rgb(100%,100%,100%)/g' \
    -e 's/#1c2023/rgb(50%,0%,0%)/g' \
     -e 's/#00E59C/rgb(0%,50%,0%)/g' \
     -e 's/#ffffff/rgb(50%,0%,50%)/g' \
     -e 's/#1a1a1a/rgb(0%,0%,50%)/g' \
	$@
