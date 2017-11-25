#!/bin/sh
#set -xe
#if [ ! -t 0 ]; then
#	x-terminal-emulator -e "$0"
#	exit 0
#fi
basedir="$(dirname "$(readlink -f "${0}")")"
cd "$basedir"
rm -vf "$basedir"/phlat_QGtkStyle.qss
for _file in $(find $basedir/DEV -mindepth 1); do
	printf "\n/*$(echo $_file|sed 's\^.*/\\')*/\n\n" >> "$basedir"/phlat_QGtkStyle.qss
	cat "$_file" >> "$basedir"/phlat_QGtkStyle.qss
done
	
