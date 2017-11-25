#!/bin/sh
sed -i \
         -e 's/#2d333f/rgb(0%,0%,0%)/g' \
         -e 's/#E5E9F0/rgb(100%,100%,100%)/g' \
    -e 's/#0b1219/rgb(50%,0%,0%)/g' \
     -e 's/#8fbcbb/rgb(0%,50%,0%)/g' \
     -e 's/#11141c/rgb(50%,0%,50%)/g' \
     -e 's/#ffffff/rgb(0%,0%,50%)/g' \
	$@
