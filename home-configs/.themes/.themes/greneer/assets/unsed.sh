#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#1A2024/g' \
         -e 's/rgb(100%,100%,100%)/#A7CEC8/g' \
    -e 's/rgb(50%,0%,0%)/#0e0e0e/g' \
     -e 's/rgb(0%,50%,0%)/#37bf8d/g' \
 -e 's/rgb(0%,50.196078%,0%)/#37bf8d/g' \
     -e 's/rgb(50%,0%,50%)/#1a1a1a/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#1a1a1a/g' \
     -e 's/rgb(0%,0%,50%)/#fff/g' \
	$@