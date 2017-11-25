#!/bin/sh
sed -i \
         -e 's/#2E3440/rgb(0%,0%,0%)/g' \
         -e 's/#eeeeec/rgb(100%,100%,100%)/g' \
    -e 's/#232f39/rgb(50%,0%,0%)/g' \
     -e 's/#8FBCBB/rgb(0%,50%,0%)/g' \
     -e 's/#232f39/rgb(50%,0%,50%)/g' \
     -e 's/#eeeeec/rgb(0%,0%,50%)/g' \
	$@
