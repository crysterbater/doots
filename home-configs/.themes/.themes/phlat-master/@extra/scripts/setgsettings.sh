#!/bin/sh
set -e
if [ ! -t 0 ]; then
	x-terminal-emulator -e "$0"
	exit 0
fi
basedir="$(dirname "$(readlink -f "${0}")")"
cd "$basedir"
if [ ! -f "$basedir"/setgsettings.sh ]; then
	printf "wrong dir!\n"
	exit 1
fi
if type gsettings >/dev/null 2>&1; then
	gsettings set org.gtk.Settings.FileChooser startup-mode cwd
elif type dconf >/dev/null 2>&1; then
	dconf write /org/gtk/settings/file-chooser/startup-mode \"cwd\"
fi
if [ -f $HOME/.config/gtk-2.0/gtkfilechooser.ini ]; then
	sed -i '/StartupMode=recent/c\StartupMode=cwd' $HOME/.config/gtk-2.0/gtkfilechooser.ini
else
	cat <<EOF >$HOME/.config/gtk-2.0/gtkfilechooser.ini
[Filechooser Settings]
StartupMode=cwd
EOF
fi
