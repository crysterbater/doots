#!/bin/sh
sed -i \
         -e 's/#dfe1e8/rgb(0%,0%,0%)/g' \
         -e 's/#1f232b/rgb(100%,100%,100%)/g' \
    -e 's/#1f232b/rgb(50%,0%,0%)/g' \
     -e 's/#7d93b3/rgb(0%,50%,0%)/g' \
     -e 's/#2b303b/rgb(50%,0%,50%)/g' \
     -e 's/#ffffff/rgb(0%,0%,50%)/g' \
	$@
