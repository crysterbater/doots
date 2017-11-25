#!/bin/bash

[[ $1 = vert ]] && width=25 || width=70
[[ $1 = vert ]] && height=70 || height=50
[[ $1 = vert ]] && position=100 || position=50

declare -A dimensions
dimensions=( ['Width']=$width ['Height']=$height ['Position']=$position )

for dimension in ${!dimensions[*]}; do
	key=$dimension
	value=${dimensions[$key]}

	sed -i "s/\(Dropdown$key\).*/\1=$value/" ~/.config/xfce4/terminal/terminalrc
done
