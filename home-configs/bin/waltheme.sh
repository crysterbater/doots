#!/bin/bash
#need to run as sudo

source "/home/knucker/.cache/wal/colors.sh"
cd /opt/oomox/colors
touch wal-theme1
rm wal-theme1
touch wal-theme1
echo  NAME="wal"  >>  wal-theme1
echo  NOGUI=True  >>  wal-theme1
echo  BG=${color0:1}  >>  wal-theme1
echo  FG=${color7:1}  >>  wal-theme1
echo  SEL_BG=${color5:1}  >>  wal-theme1
echo  SEL_FG=${color15:1}  >>  wal-theme1
echo  TXT_BG=${color0:1}  >>  wal-theme1
echo  TXT_FG=${color7:1}  >>  wal-theme1
echo  MENU_BG=${color0:1}  >>  wal-theme1
echo  MENU_FG=${color7:1}  >>  wal-theme1
echo  BTN_BG=${color8:1}  >>  wal-theme1
echo  BTN_FG=${color15:1}  >>  wal-theme1
echo  ROUNDNESS=2 >>  wal-theme1
echo  SPACING=3 >>  wal-theme1
echo  GRADIENT=0.0 >>  wal-theme1
echo  GTK3_GENERATE_DARK=True >>  wal-theme1
echo  ICONS_STYLE=archdroid >> wal-theme1
echo  ICONS_ARCHDROID=${color5:1} >>  wal-theme1
