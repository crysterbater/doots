#!/bin/bash

hander_directory="$(dirname $0)/rofi_modules"
LOG_PATH=/home/$USER/.custom_rofi_logs

[[ ! -d $LOG_PATH ]] && mkdir -p $LOG_PATH

for include_file in $(ls -l $hander_directory | grep -v '^d' | grep -v '^total' | awk '{print $9}'); do
    echo "Loading:" $include_file
    . "$hander_directory/$include_file"
done

content=$(ls -l $hander_directory | grep -v '^d' | grep -v '^total' | awk '{print $9}' | sed 's/.sh//g
                                      s/_/ /g')


Custom_handler() {
    [[ $1 ]] && $1_handler "$(echo $1 | sed 's/_/ /g')"
}

Custom_handler $(echo $(echo "$content" | rofi -i -dmenu -fuzzy -l 5 -p '↠') | sed 's/ /_/g')

# Cleanup of logs
#  - removing non-unique log-entries
#  - removing entries past the set limit

LOG_ENTRIES_TO_KEEP=50

LOG_FILES=$(ls $LOG_PATH)
for log_file in $LOG_FILES; do
    log_file_path=$LOG_PATH/$log_file
    touch $log_file_path
    log_content=$(tac $log_file_path | sort -u | head -n $LOG_ENTRIES_TO_KEEP)
    echo "$log_content" > $log_file_path
done
