#!/bin/bash

echo "Making GTK-2.0 Assets"
echo
cd ../src/gtk-2.0
echo "making the assets of gtk-2.0/render-assets"
echo
sh render-assets.sh
echo
echo
echo "Making GTK-3.0 Assets"
echo
cd ../gtk-3.0
echo
sh render-assets.sh
echo
echo
echo
cd ../xfwm4
echo "Making Xfwm4 Assets"
echo
sh render-assets.sh

