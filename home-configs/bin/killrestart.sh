#!/bin/bash                                                                                    
                                                                               
pgrep -a $1 | while read -r line; do                                           
        kill $(cut -d' ' -f1 <<< $line)                                        
        eval nohup $(cut -d' ' -f2- <<< $line) >/dev/null 2>&1 &               
done
