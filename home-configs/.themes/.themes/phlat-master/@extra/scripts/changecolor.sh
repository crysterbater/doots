#!/bin/sh
#set -xe
#if [ ! -t 0 ]; then
#	x-terminal-emulator -e "$0"
#	exit 0
#fi
basedir="$(dirname "$(readlink -f "${0}")")/../.."
cd "$basedir"
color="$1"
case $color in
	-c|--color)
	newcolor="$2";;
esac
#well, we need some common tools
type sed >/dev/null 2>&1 &&
type tr >/dev/null 2>&1 &&
type find >/dev/null 2>&1||_missingdep=true
case $_missingdep in
	true)
		if type yad >/dev/null 2>&1; then
			yad --on-top --center --title Error --image=dialog-error --text "\nYou either miss sed, tr, or find!" --button="gtk-ok:0"
		else
			printf "You either miss sed, tr, or find! Aborting!\n"
		fi
		exit 1;;
esac
#check if we have permissions
if [ ! -w "$basedir"/@extra ]; then
		if type yad >/dev/null 2>&1; then
			yad --on-top --center --title Error --image=dialog-error --text "\nYou don't have write permissions!" --button="gtk-ok:0"
		else
			printf "You don't have write permissions!\n"
		fi
		exit 1
fi
#check for the right dir
if [ ! -d "$basedir"/@extra ]; then
	printf "wrong dir!\n"
	exit 1
fi
####################
###set the color
####################
while [ 1 ];do
	_has_error=0
	if [ -z ${newcolor} ]; then 
		if type yad >/dev/null 2>&1; then
			newcolor=$(yad --on-top --center --always-print-result --color --init-color=#a070be --title="Please select a new #RRGGBB hilight color")
		else
			read -p "Please enter your new hilight color in #RRGGBB(The '#' is a must!, #a070be is currently set): " newcolor
		fi
	fi
#check if there is a color
	if [ -z ${newcolor+x} ]; then
		_has_error=1
		if type yad >/dev/null 2>&1; then
			yad --on-top --center --title Error --image=dialog-error --text "\nNo color was was selected!"
		else
			printf "No color was was selected\n"
		fi
	fi
#some fail colors(colors already used by theme)
	case "$(echo ${newcolor}|sed 's/#//'|tr '[:upper:]' '[:lower:]')" in
		424141|ffffff|f1f2f2|656666|323131|2980b9|bdc3c7|cc0000|3366cc|ff6600|669900|5e86d7)
		if type yad >/dev/null 2>&1; then
			yad --on-top --center --title Error --image=dialog-error --text "\nSorry the colors: 424141,ffffff,f1f2f2,656666,323131,2980b9,bdc3c7,cc0000,3366cc,ff6600,669900,5e86d7 are not available!" --button="gtk-ok:0"
		else
			printf "\nSorry the colors: 424141,ffffff,f1f2f2,656666,323131,2980b9,bdc3c7,cc0000,3366cc,ff6600,669900,5e86d7 are not available!\n"
		fi
		_has_error=1;;
	esac
#check if we have a proper hex color #RRGGBB
	if [ "${#newcolor}" -lt 7 ]; then
		_has_error=1
		if type yad >/dev/null 2>&1; then
			yad --on-top --center --title Error --image=dialog-error --text "\nSorry ${newcolor} is not a valid color!" --button="gtk-ok:0"
		else
			printf "\nSorry ${newcolor} is not a valid color!\n"
		fi
	fi
	if [ "$_has_error" = "0" ]; then
		break
	else
		unset newcolor
	fi
done
#recolor the ui themes
_folders="images gtk-3.0 gtk-2.0 gtk xfwm4 xfdashboard-1.0 openbox-3 balou @extra"
for _folder in $_folders; do
	cd $_folder
	find "$basedir/$_folder" -type f -exec sed -i 's/#a070be/'$newcolor'/g' {} \;
	find "$basedir/$_folder" -type f -exec sed -i 's/#A070BE/'$newcolor'/g' {} \;
	cd $basedir
done
printf "\n\ndone\n\n"

