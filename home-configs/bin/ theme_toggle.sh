#!/bin/sh

# theme_toggle.sh
# Original author: Hiradur
# License: CC0
# Description: Toggle between two themes for various applications
# designed for the Solarized themes by Ethan Schoonover

# This script toggles between a light and a dark theme for various applications
# by replacing the corresponding option(s) in their config files
# You need to have the Solarized Light/Dark theme installed for these applications

# Currently supported applications:
# background image, urxvt, zathura, vimperator (FF addon), GTK2/3-apps

# Tip: For a complete solarized experience you can use the Stylish addon for
# Firefox with Solarized dark/light Everywhere theme. It's not toggled here
# because it breaks the layout of a few websites.

# check which theme is active first
grep -q '#include ".urxvt/themes/solarized_light"' ~/.Xdefaults
if [ $? -eq 0 ]; then
    # light theme active, switch to dark theme

    # background
    xsetroot -solid "#002b36"
    # urxvt
    sed -i 's|#include ".urxvt/themes/solarized_light"|#include ".urxvt/themes/solarized_dark"|' ~/.Xdefaults
    # zathura
    sed -i 's|set recolor-lightcolor     "#fdf6e3" #00|set recolor-lightcolor     "#002b36" #00|' ~/.config/zathura/zathurarc
    sed -i 's|set recolor-darkcolor      "#657b83" #06|set recolor-darkcolor      "#839496" #06|' ~/.config/zathura/zathurarc
    # vimperator
    sed -i 's|colorscheme solarized_light|colorscheme solarized_dark|' ~/.vimperatorrc
    # GTK
    sed -i 's|gtk-theme-name="Numix Solarized Light"|gtk-theme-name="Numix Solarized"|' ~/.gtkrc-2.0
    sed -i 's|gtk-theme-name=Numix Solarized Light|gtk-theme-name=Numix Solarized|' ~/.config/gtk-3.0/settings.ini
else
    # switch to light theme
    xsetroot -solid "#fdf6e3"
    sed -i 's|#include ".urxvt/themes/solarized_dark"|#include ".urxvt/themes/solarized_light"|' ~/.Xdefaults
    sed -i 's|set recolor-lightcolor     "#002b36" #00|set recolor-lightcolor     "#fdf6e3" #00|' ~/.config/zathura/zathurarc
    sed -i 's|set recolor-darkcolor      "#839496" #06|set recolor-darkcolor      "#657b83" #06|' ~/.config/zathura/zathurarc
    sed -i 's|colorscheme solarized_dark|colorscheme solarized_light|' ~/.vimperatorrc
    sed -i 's|gtk-theme-name="Numix Solarized"|gtk-theme-name="Numix Solarized Light"|' ~/.gtkrc-2.0
    sed -i 's|gtk-theme-name=Numix Solarized|gtk-theme-name=Numix Solarized Light|' ~/.config/gtk-3.0/settings.ini
fi
