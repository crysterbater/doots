#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#18191a/g' \
         -e 's/rgb(100%,100%,100%)/#eeeeec/g' \
    -e 's/rgb(50%,0%,0%)/#18191a/g' \
     -e 's/rgb(0%,50%,0%)/#18191a/g' \
 -e 's/rgb(0%,50.196078%,0%)/#18191a/g' \
     -e 's/rgb(50%,0%,50%)/#18191a/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#18191a/g' \
     -e 's/rgb(0%,0%,50%)/#eeeeec/g' \
	$@