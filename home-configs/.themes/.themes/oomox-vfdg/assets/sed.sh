#!/bin/sh
sed -i \
         -e 's/#131a1f/rgb(0%,0%,0%)/g' \
         -e 's/#ffffff/rgb(100%,100%,100%)/g' \
    -e 's/#171d2b/rgb(50%,0%,0%)/g' \
     -e 's/#edafb8/rgb(0%,50%,0%)/g' \
     -e 's/#0c1015/rgb(50%,0%,50%)/g' \
     -e 's/#f5f5f5/rgb(0%,0%,50%)/g' \
	$@
