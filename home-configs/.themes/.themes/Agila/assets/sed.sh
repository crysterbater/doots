#!/bin/sh
sed -i \
         -e 's/#111112/rgb(0%,0%,0%)/g' \
         -e 's/#A7CEC8/rgb(100%,100%,100%)/g' \
    -e 's/#0e0e11/rgb(50%,0%,0%)/g' \
     -e 's/#9AD2C2/rgb(0%,50%,0%)/g' \
     -e 's/#1B1D21/rgb(50%,0%,50%)/g' \
     -e 's/#D2E7E4/rgb(0%,0%,50%)/g' \
	$@