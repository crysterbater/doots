#!/bin/bash
#
 
MYSHELL=/bin/bash
HISTORYFILE=/var/tmp/bashcmd.rofi.list
TERMINAL=/usr/bin/urxvt
 
if [[ -z "$@" ]]
then
    sort ${HISTORYFILE} 2>/dev/null || echo "just issue command being executed via ${MYSHELL}"
else
    grep -q "^$@$" ${HISTORYFILE} &>/dev/null || echo "$@" >> ${HISTORYFILE}
    coproc ( ${MYSHELL} -c "$@"  &> /dev/null )
fi
