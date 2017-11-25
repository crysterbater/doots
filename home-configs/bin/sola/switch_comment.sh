#!/bin/bash

#$1 search_pattern
#$2 group_beggining (' ' if commenting, '#' if uncommentingi)
#$3 line_new_beggingig ('#' if commenting, '' if uncommentingi)
#$4 file_path
switch_comment() {
	sed -i "/$1/ s/$2*/$3/" $4
	#sed '/najjaci/ s/ *\(.*\)/# \1/ Desktop/test
}

switch_comment "$@"

cat $4
