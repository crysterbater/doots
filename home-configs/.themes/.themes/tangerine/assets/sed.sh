#!/bin/sh
sed -i \
         -e 's/#ffffff/rgb(0%,0%,0%)/g' \
         -e 's/#091b2c/rgb(100%,100%,100%)/g' \
    -e 's/#121517/rgb(50%,0%,0%)/g' \
     -e 's/#f8818e/rgb(0%,50%,0%)/g' \
     -e 's/#1E1E20/rgb(50%,0%,50%)/g' \
     -e 's/#eeeeec/rgb(0%,0%,50%)/g' \
	$@
