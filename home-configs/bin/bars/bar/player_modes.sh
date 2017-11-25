#!/bin/bash

path=~/Desktop/bar/player.sh

command() {
	command="sed -i 's/\(player=.*\)$1\().*\)/\1$2\2/'"
	echo "$command ~/Desktop/bar/media.sh && $command ~/Desktop/bar/media_controls.sh"
}

if [ $1 ]; then
	open="%{A:$path OPEN:} %{A}"
	open_vert="%{A:$path OPEN VERT:} %{A}"
	open_vert_bottom="%{A:$path OPEN VERT BOTTOM:} %{A}"
	#list="%{A:$path LIST:} %{A}"
	#visualizer="%{A:$path VISUALIZER:} %{A}" 	# 				 
	#default="%{A:$path DEFAULT:} %{A}"
	close="%{A:$(command ' .*' ''):} %{A}  " 	# 

	echo -e "$open$open_vert$open_vert_bottom$list$visualizer$default$close"
else
	echo "%{A:$(command '' ' modes'):} %{A}" 	# 
fi
