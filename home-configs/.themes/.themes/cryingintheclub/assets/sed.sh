#!/bin/sh
sed -i \
         -e 's/#0b1219/rgb(0%,0%,0%)/g' \
         -e 's/#cccccc/rgb(100%,100%,100%)/g' \
    -e 's/#06121d/rgb(50%,0%,0%)/g' \
     -e 's/#16adac/rgb(0%,50%,0%)/g' \
     -e 's/#0e161e/rgb(50%,0%,50%)/g' \
     -e 's/#ffffff/rgb(0%,0%,50%)/g' \
	$@
