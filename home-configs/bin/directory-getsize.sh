#!/bin/bash

for I in "$@"
do
    query+=("${I}")
done

if [ -n "$query" ]
then
    total=$(du --summarize --total --block-size=1M "${query[@]}" | sed 's/\t/M: /')

    (( WIDTH = 35 + 7 * $(wc -L <<< "$total") ))
    (( HEIGHT = 80 + 23 * $(wc -l <<< "$total") ))

    whiptail --title "Total Disk Usage" --msgbox "$total" 8 78

fi

exit 0
