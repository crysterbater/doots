#!/bin/sh
sed -i \
         -e 's/#fafbfc/rgb(0%,0%,0%)/g' \
         -e 's/#5d5d60/rgb(100%,100%,100%)/g' \
    -e 's/#51589f/rgb(50%,0%,0%)/g' \
     -e 's/#e1e6ed/rgb(0%,50%,0%)/g' \
     -e 's/#0c1014/rgb(50%,0%,50%)/g' \
     -e 's/#ffffff/rgb(0%,0%,50%)/g' \
	$@
