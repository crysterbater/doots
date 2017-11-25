#!/bin/sh
sed -i \
         -e 's/#05090D/rgb(0%,0%,0%)/g' \
         -e 's/#dfddd5/rgb(100%,100%,100%)/g' \
    -e 's/#0c0c0c/rgb(50%,0%,0%)/g' \
     -e 's/#A61C52/rgb(0%,50%,0%)/g' \
     -e 's/#0C1014/rgb(50%,0%,50%)/g' \
     -e 's/#eeeeec/rgb(0%,0%,50%)/g' \
	$@
