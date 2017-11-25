#!/bin/sh
#
# Simple shell script to copy a file to the Dropbox
# public folder and get its URL.
#
# The URL of the last file copied also stays on the
# X clipboard.
#
# Symlink the script as dropmv to move the file to the
# public folder instead of copying it.
#
# Author: Tamas Nepusz <ntamas at gmail dot com>
#
# This script has been placed in the public domain.

DROPBOX_ROOT=~/.dropbox
DROPBOX_REPO=~/Dropbox

if [ $# -eq 0 ]; then
    echo "Usage: $0 file1 [file2] [file3] ..."
fi

SOCAT=`which socat`
if [ $? != 0 ]; then
    echo "Please install socat if you want to use this script."
    exit 1
fi

XCLIP=`which xclip`
if [ $? != 0 ]; then
    echo "Please install xclip if you want to use this script."
    exit 1
fi

SOCKET="$DROPBOX_ROOT/command_socket"
if [ ! -S $SOCKET ]; then
    echo "Dropbox daemon not running, exiting..."
    exit 2
fi

CP=cp
if [ `basename $0` = dropmv ]; then
    CP=mv
fi

while [ $# -ne 0 ]; do
    echo | $XCLIP -sel clip
    DEST="$DROPBOX_REPO/Public/$1"
    $CP "$1" "$DEST"
    $SOCAT - $SOCKET >/dev/null <<EOF
icon_overlay_context_action
verb    copypublic
paths    $DEST
done
EOF
    URL="`$XCLIP -sel clip -o`"
    if [ "x$URL" = x ]; then
        echo "error while retrieving URL for $DEST" >&2
    else
        echo $URL
    fi
    shift
done
