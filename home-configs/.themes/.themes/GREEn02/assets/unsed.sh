#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#2b2e3c/g' \
         -e 's/rgb(100%,100%,100%)/#eeeeec/g' \
    -e 's/rgb(50%,0%,0%)/#16181e/g' \
     -e 's/rgb(0%,50%,0%)/#92f9b2/g' \
 -e 's/rgb(0%,50.196078%,0%)/#92f9b2/g' \
     -e 's/rgb(50%,0%,50%)/#16181e/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#16181e/g' \
     -e 's/rgb(0%,0%,50%)/#eeeeec/g' \
	$@