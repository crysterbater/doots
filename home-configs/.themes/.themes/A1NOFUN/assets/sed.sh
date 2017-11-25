#!/bin/sh
sed -i \
         -e 's/#111111/rgb(0%,0%,0%)/g' \
         -e 's/#ffffff/rgb(100%,100%,100%)/g' \
    -e 's/#1A1A1A/rgb(50%,0%,0%)/g' \
     -e 's/#ff4160/rgb(0%,50%,0%)/g' \
     -e 's/#ffffff/rgb(50%,0%,50%)/g' \
     -e 's/#1A1A1A/rgb(0%,0%,50%)/g' \
	$@
