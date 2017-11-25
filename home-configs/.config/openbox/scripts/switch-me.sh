#!/bin/bash

echo "termite..."
cp themes/$1/termite_conf ~/.config/termite/config
echo "openbox config..."
cp themes/$1/openbox/menu.xml ~/.config/openbox/menu.xml
cp themes/$1/openbox/rc.xml ~/.config/openbox/rc.xml
echo "openbox theme..."
cp -r themes/$1/openbox_theme ~/.themes/$1
echo "tint2..."
cp themes/$1/tint2_conf ~/.config/tint2/tint2rc
echo "wallpaper..."
feh --bg-scale themes/$1/wallpaper.png

echo "Everything done! yay!"
