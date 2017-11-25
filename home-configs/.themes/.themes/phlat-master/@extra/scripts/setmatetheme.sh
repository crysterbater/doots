#!/bin/sh
set -e
if [ ! -t 0 ]; then
	x-terminal-emulator -e "$0"
	exit 0
fi
basedir="$(dirname "$(readlink -f "${0}")")"
cd "$basedir"
if [ ! -f "$basedir"/setmatetheme.sh ]; then
	printf "wrong dir!\n"
	exit 1
fi
### set theme
if [ -f $HOME/.gtkrc-2.0 ]; then
	yad --title "Warning!" --text="Custom GTK2 settings are set!" --image="dialog-warning" --button="gtk-ok:0"
fi
if [ -f $HOME/.config/gtk-3.0/settings.ini ]; then
	yad --title "Warning!" --text="Custom GTK3 settings are set!" --image="dialog-warning" --button="gtk-ok:0"
fi
if type gsettings >/dev/null 2>&1; then
	gsettings set org.mate.Marco.general compositing-manager true || true
	gsettings set org.mate.Marco.general button-layout ':minimize,maximize,close' || true
	gsettings set org.mate.Marco.general center-new-windows true || true
	gsettings set org.mate.Marco.general theme 'phlat' || true
	gsettings set org.mate.interface gtk-dialogs-use-header false || true
	gsettings set org.mate.interface toolbar-style 'icons' || true
	gsettings set org.mate.interface buttons-have-icons false || true
	gsettings set org.mate.interface menus-have-icons true || true
	gsettings set org.mate.interface gtk-decoration-layout ':' || true
	gsettings set org.mate.interface gtk-overlay-scrolling false ||true
	gsettings set org.mate.interface gtk-theme 'phlat'|| true
	gsettings set org.mate.interface icon-theme 'phlat' || true
	gsettings set org.mate.NotificationDaemon theme 'coco' || true
fi
printf "\ndone\n"
sh "$basedir"/setgsettings.sh
