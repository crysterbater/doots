#!/bin/bash

path=~/.dotfiles/bar

volume_up=$2
volume_step=$(echo $2 | sed -r 's/.*([0-9]{1,2}).*/\1/')
volume_down=$(echo $2 | sed 's/\(.* \)\(.*\)+\(.*\).*/\1\2-\3/')

value=$(echo $3 | grep -o '[0-9]*')
[[ $value ]] && case 1 in
	$(($value == 0))) icon=" ";;
	$(($value < 15))) icon="";;
	$(($value < 40))) icon="";;
	$(($value < 70))) icon=" ";;
	*) icon=" ";;
esac || exit 0

[[ $1 == "MEDIA" ]] && space='%{O15}'

command() {
	command="sed -i 's/\(volume=.*\)$2\().*\)/\1$3\2/'"
	[[ $1 == "MEDIA" ]] && echo "$command $path/media.sh && $command $path/media_controls.sh" \
		|| echo "$command $path/system_info.sh"
}

if [[ $4 ]]; then
	echo "$space%{A:$volume_down:} %{A}%{A:$(command $1 ' .*' ''):}$3 %{A}%{A:$volume_up:} %{A}"
else
	echo "$space%{A4:$volume_up:}%{A5:$volume_down:}%{A:$(command $1 '' ' controls'):}$icon%{A}%{A}%{A}$3"
fi
