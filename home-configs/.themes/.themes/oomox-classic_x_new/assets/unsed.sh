#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#d4d0c8/g' \
         -e 's/rgb(100%,100%,100%)/#0e0e0e/g' \
    -e 's/rgb(50%,0%,0%)/#2c303b/g' \
     -e 's/rgb(0%,50%,0%)/#38bf8f/g' \
 -e 's/rgb(0%,50.196078%,0%)/#38bf8f/g' \
     -e 's/rgb(50%,0%,50%)/#f8f8f8/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#f8f8f8/g' \
     -e 's/rgb(0%,0%,50%)/#0e0e0e/g' \
	$@