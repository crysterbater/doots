#!/bin/sh
sed -i \
         -e 's/#2b2a2f/rgb(0%,0%,0%)/g' \
         -e 's/#ffffff/rgb(100%,100%,100%)/g' \
    -e 's/#3c3c3c/rgb(50%,0%,0%)/g' \
     -e 's/#3abcb6/rgb(0%,50%,0%)/g' \
     -e 's/#ffffff/rgb(50%,0%,50%)/g' \
     -e 's/#1a1a1a/rgb(0%,0%,50%)/g' \
	$@
