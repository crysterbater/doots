#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TERMINAL=gnome-terminal

if [ $# -eq 0 ]
then
    if [ -e ${__dir}/../.cache/directories.db ]
    then
        cat ${__dir}/../.cache/directories.db
    else
        find ~ -type d | grep -v -f ${__dir}/../ignore_paths
    fi
else
    DIRECTORY=$@
    ${TERMINAL} --working-directory ${DIRECTORY}
fi
