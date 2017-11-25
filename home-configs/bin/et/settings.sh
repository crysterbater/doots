#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

update_cache() {
    clear_cache

    # XXX
    ${__dir}/modes/directories.sh > ${__dir}/.cache/directories_new.db
    ${__dir}/modes/files.sh > ${__dir}/.cache/files_new.db

    mv ${__dir}/.cache/directories_new.db ${__dir}/.cache/directories.db
    mv ${__dir}/.cache/files_new.db ${__dir}/.cache/files.db
}

clear_cache() {
    rm -f ${__dir}/.cache/directories.db
    rm -f ${__dir}/.cache/files.db
}

mkdir -p ${__dir}/.cache/

if [ $# -eq 0 ]
then
    echo 'clear_cache'
    echo 'update_cache'
else
    if [ $1 = 'update_cache' ]
    then
        update_cache
    elif [ $1 = 'clear_cache' ]
    then
        clear_cache
    fi
fi
