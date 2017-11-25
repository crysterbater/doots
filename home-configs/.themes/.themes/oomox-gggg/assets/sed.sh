#!/bin/sh
sed -i \
         -e 's/#0d1116/rgb(0%,0%,0%)/g' \
         -e 's/#eeeeec/rgb(100%,100%,100%)/g' \
    -e 's/#090A0A/rgb(50%,0%,0%)/g' \
     -e 's/#0b81a9/rgb(0%,50%,0%)/g' \
     -e 's/#0b0c0c/rgb(50%,0%,50%)/g' \
     -e 's/#eeeeec/rgb(0%,0%,50%)/g' \
	$@
