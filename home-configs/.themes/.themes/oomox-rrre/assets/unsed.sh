#!/bin/sh
sed -i \
         -e 's/rgb(0%,0%,0%)/#1F292F/g' \
         -e 's/rgb(100%,100%,100%)/#e5e5e5/g' \
    -e 's/rgb(50%,0%,0%)/#18262F/g' \
     -e 's/rgb(0%,50%,0%)/#655988/g' \
 -e 's/rgb(0%,50.196078%,0%)/#655988/g' \
     -e 's/rgb(50%,0%,50%)/#18262F/g' \
 -e 's/rgb(50.196078%,0%,50.196078%)/#18262F/g' \
     -e 's/rgb(0%,0%,50%)/#D2E7E4/g' \
	$@