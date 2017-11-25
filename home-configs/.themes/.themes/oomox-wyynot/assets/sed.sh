#!/bin/sh
sed -i \
         -e 's/#f2f2f2/rgb(0%,0%,0%)/g' \
         -e 's/#1a1a1a/rgb(100%,100%,100%)/g' \
    -e 's/#ffffff/rgb(50%,0%,0%)/g' \
     -e 's/#ff4f7f/rgb(0%,50%,0%)/g' \
     -e 's/#232324/rgb(50%,0%,50%)/g' \
     -e 's/#D2E7E4/rgb(0%,0%,50%)/g' \
	$@
