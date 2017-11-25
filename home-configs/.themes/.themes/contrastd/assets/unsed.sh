#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#2b2a2f/g' \
         -e 's/rgb(100%,100%,100%)/#ffffff/g' \
    -e 's/rgb(50%,0%,0%)/#3c3c3c/g' \
     -e 's/rgb(0%,50%,0%)/#3abcb6/g' \
 -e 's/rgb(0%,50.196078%,0%)/#3abcb6/g' \
     -e 's/rgb(50%,0%,50%)/#ffffff/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#ffffff/g' \
     -e 's/rgb(0%,0%,50%)/#1a1a1a/g' \
	$@
