#!/bin/sh
sed -i \
         -e 's/#2b2e3c/rgb(0%,0%,0%)/g' \
         -e 's/#eeeeec/rgb(100%,100%,100%)/g' \
    -e 's/#16181e/rgb(50%,0%,0%)/g' \
     -e 's/#92f9b2/rgb(0%,50%,0%)/g' \
     -e 's/#16181e/rgb(50%,0%,50%)/g' \
     -e 's/#eeeeec/rgb(0%,0%,50%)/g' \
	$@
