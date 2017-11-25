#!/bin/sh
sed -i \
         -e 's/#272c38/rgb(0%,0%,0%)/g' \
         -e 's/#eeeeec/rgb(100%,100%,100%)/g' \
    -e 's/#101517/rgb(50%,0%,0%)/g' \
     -e 's/#8EBDD5/rgb(0%,50%,0%)/g' \
     -e 's/#20222b/rgb(50%,0%,50%)/g' \
     -e 's/#eeeeec/rgb(0%,0%,50%)/g' \
	$@
