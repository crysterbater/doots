#!/bin/sh
set -e
if [ ! -t 0 ]; then
	x-terminal-emulator -e "$0"
	exit 0
fi
basedir="$(dirname "$(readlink -f "${0}")")"
cd "$basedir"
if [ ! -f "$basedir"/setxfcetheme.sh ]; then
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
if type xfconf-query >/dev/null 2>&1; then
	xfconf-query -c xsettings -p /Net/ThemeName -s "phlat" || true
	xfconf-query -c xsettings -p /Gtk/ButtonImages -s false || true
	xfconf-query -c xsettings -p /Gtk/MenuImages -s true || true
	xfconf-query -c xfwm4 -p /general/theme -s "phlat" || true
	xfconf-query -c xfce4-notifyd -p /theme -s "phlat" || true
	xfconf-query -c xfce4-session -p /splash/Engine -s "balou" || true
	xfconf-query -c xfce4-session -p /splash/engines/balou/Theme -s "phlat" || true
	xfconf-query -c xfdashboard -p /theme -s "phlat" || true
	xfconf-query -c xsettings -p /Net/IconThemeName -s "phlat" || true
fi
printf "\ndone\n"
sh "$basedir"/setgsettings.sh
