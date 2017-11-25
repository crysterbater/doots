#!/bin/sh
sed -i \
         -e 's/#080e14/rgb(0%,0%,0%)/g' \
         -e 's/#eeeeec/rgb(100%,100%,100%)/g' \
    -e 's/#0b1219/rgb(50%,0%,0%)/g' \
     -e 's/#14b2de/rgb(0%,50%,0%)/g' \
     -e 's/#0c1823/rgb(50%,0%,50%)/g' \
     -e 's/#eeeeec/rgb(0%,0%,50%)/g' \
	$@
