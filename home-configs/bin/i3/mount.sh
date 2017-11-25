#/bin/bash

for d in /dev/sd*

do
if [[ $(blkid -o value -s UUID $d ) = '1A3FE4E62BC1A399' ]]; then
	mkdir -p /mnt/wd2
	mount $d /mnt/wd2
	echo "2TB WD drive mounted to /mnt/wd2."

elif [[ $(blkid -o value -s UUID $d ) = '9C33-6BBD' ]]; then
	mkdir -p /mnt/sd
	mount $d /mnt/sd
	echo "SD card mounted to /mnt/sd."

elif [[ $(blkid -o value -s UUID $d ) = 'E642-81B1' ]]; then
	mkdir -p /mnt/blue
	mount $d /mnt/blue
	echo "Blue USB mounted to /mnt/blue."

elif [[ $(blkid -o value -s UUID $d ) = '66faa60c-b24f-46a6-92cd-b064e9dbdc6c' ]]; then
	mkdir -p /mnt/king
	mount $d /mnt/king
	echo "Kingston USB mounted to /mnt/king."

elif [[ $(blkid -o value -s UUID $d ) = '6C67-A7B4' ]]; then
	mkdir -p /mnt/sony4
	mount $d /mnt/sony4
	echo "Sony USB mounted to /mnt/sony4."

elif [[ $(blkid -o value -s UUID $d ) = '0ff55b51-5294-4bc2-bbf0-819a804b0503' ]]; then
	mkdir -p /mnt/black
	mount $d /mnt/black
	echo "Black USB mounted to /mnt/black."
fi

done
