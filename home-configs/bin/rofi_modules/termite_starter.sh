#!/bin/bash

CONFIG="${HOME}/.config/termite/config"
HOSTNAME=`hostname`

if [[ -e ${CONFIG}_${HOSTNAME} ]]; then
    CONFIG="${CONFIG}_${HOSTNAME}"
fi

exec /usr/bin/termite -c ${CONFIG}
