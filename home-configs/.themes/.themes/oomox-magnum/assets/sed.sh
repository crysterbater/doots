#!/bin/sh
sed -i \
         -e 's/#121417/rgb(0%,0%,0%)/g' \
         -e 's/#eeeeec/rgb(100%,100%,100%)/g' \
    -e 's/#2b2d3a/rgb(50%,0%,0%)/g' \
     -e 's/#5C7082/rgb(0%,50%,0%)/g' \
     -e 's/#1E1E20/rgb(50%,0%,50%)/g' \
     -e 's/#eeeeec/rgb(0%,0%,50%)/g' \
	$@
