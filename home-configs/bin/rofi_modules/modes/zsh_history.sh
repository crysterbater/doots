#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

TERMINAL=gnome-terminal

if [ $# -eq 0 ]
then
    cat ~/.zsh_history \
        | cut -c 16- \
        | grep -v -f ${__dir}/../ignore_history \
        | sort \
        | uniq -c \
        | sort -nr \
        | awk '(NR>1) && ($1 > 1)' \
        | sed 's/^[0-9 ]\+//'
else
    COMMAND=$@
    $TERMINAL --command "$COMMAND"
fi
