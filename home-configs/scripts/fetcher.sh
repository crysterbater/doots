#!/bin/bash

cat /tmp/currentpic | xargs rm
pic=$(ls -t /tmp/jonpic*.jpg | head -n 1);
echo "$pic" > /tmp/currentpic

rand=$(/usr/bin/openssl rand -base64 12)
FILE="/tmp/jonpic$rand.jpg"
/usr/local/bin/wget -O "$FILE" "https://source.unsplash.com/random/2560x1440" &

osascript <<END
    tell application "System Events"
        set desktopCount to count of desktops
        repeat with desktopNumber from 1 to desktopCount
            tell desktop desktopNumber
                set picture to "$pic"
            end tell
        end repeat
    end tell
END

files=$(ls -tl /tmp/jonpic*.jpg)
fileslen=$(echo "$files" | wc -l)
diff=$((10-fileslen))

if [[ $diff -gt 0 ]]; then
    for i in $(seq 1 $diff); do
        echo 'Rebuilding pic library'
        rand=$(/usr/bin/openssl rand -base64 12)
        FILE="/tmp/jonpic$rand.jpg"
        /usr/local/bin/wget -O "$FILE" "https://source.unsplash.com/random/2560x1440"
        echo "Fetched new pic $FILE";
    done
fi

echo 'Done.'
