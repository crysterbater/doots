#!/bin/sh
set -e
if [ ! -t 0 ]; then
	x-terminal-emulator -e "$0"
	exit 0
fi
basedir="$(dirname "$(readlink -f "${0}")")"
cd "$basedir"
if [ ! -f "$basedir"/setxfcetheme-hidpi.sh ]; then
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
	xfconf-query -c xsettings -p /Net/ThemeName -s "phlat-HiDPI" || true
	xfconf-query -c xsettings -p /Gtk/ButtonImages -s false || true
	xfconf-query -c xsettings -p /Gtk/MenuImages -s true || true
	xfconf-query -c xfwm4 -p /general/theme -s "phlat-HiDPI" || true
	xfconf-query -c xfce4-notifyd -p /theme -s "phlat-HiDPI" || true
	xfconf-query -c xfce4-session -p /splash/Engine -s "balou" || true
	xfconf-query -c xfce4-session -p /splash/engines/balou/Theme -s "phlat-HiDPI" || true
	xfconf-query -c xfdashboard -p /theme -s "phlat-HiDPI" || true
	xfconf-query -c xsettings -p /Xft/DPI -s "192" || true
	xfconf-query -c xsettings -p /Net/IconThemeName -s "phlat" || true
fi
if type yad >/dev/null 2>&1; then
	yad --title "GTK3 HiDPI" --text="Also don't forget to add GDK_SCALE=2 to your environment!" --image="dialog-information" --button="gtk-ok:0"
else
	printf "\nAlso don't forget to add GDK_SCALE=2 to your environment!\n"
fi
if type yad >/dev/null 2>&1; then
	yad --title "Qt5 HiDPI" --text="Add QT_SCALE_FACTOR=2 to your environment for Qt5 support" --image="dialog-information" --button="gtk-ok:0"
else
	printf "\nAdd QT_SCALE_FACTOR=2 to your environment for Qt5 support\n"
fi
if type yad >/dev/null 2>&1; then
	printf 'xfconf-query -c xsettings -p /Gtk/IconSizes -s "gtk-menu=32,32:gtk-small-toolbar=48,48:gtk-large-toolbar=48,48:gtk-dnd=96,96:gtk-button=48,48:gtk-dialog=96,96:gtk-panel=48,48:panel-applications-menu=48,48:panel-tasklist-menu=64,64:panel-menu=48,48:panel-directory-menu=48,48:panel-launcher-menu=48,48:panel-window-menu=48,48:panel-menu-bar=48,48:ev-icon-size-annot-window=32,32:webkit-media-button-size=48,48"' >/tmp/hidpixfconf.phlat

	yad --text-info --title "GTK2 HiDPI Icons" --text='You might need to double the GTK2 icon size eg:' --filename="/tmp/hidpixfconf.phlat" --image="dialog-information" --button="gtk-ok:0"
else
	cat <<\EOF
	
You might need to double the GTK2 icon size eg:

xfconf-query -c xsettings -p /Gtk/IconSizes -s "gtk-menu=32,32:gtk-small-toolbar=48,48:gtk-large-toolbar=48,48:gtk-dnd=96,96:gtk-button=48,48:gtk-dialog=96,96:gtk-panel=48,48:panel-applications-menu=48,48:panel-tasklist-menu=64,64:panel-menu=48,48:panel-directory-menu=48,48:panel-launcher-menu=48,48:panel-window-menu=48,48:panel-menu-bar=48,48:ev-icon-size-annot-window=32,32:webkit-media-button-size=48,48"

EOF
fi
printf "\ndone\n"
sh "$basedir"/setgsettings.sh
