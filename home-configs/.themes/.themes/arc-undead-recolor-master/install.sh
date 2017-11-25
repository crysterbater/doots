#!/bin/bash

# Read in variables from config
. ./conf

TARGET="/usr/share/themes/$NAME"

echo "Checking deps..."

# Check deps
if ! type inkscape; then
    echo "inkscape is not installed, needed for (re)rendering vectors. Exiting..."
    exit 1
fi
if ! type optipng; then
    echo "optipng is not installed, needed for (re)rendering vectors. Exiting..."
    exit 1
fi

# Remove old directories
rm -rf "$TARGET"

# Create required directories
mkdir -p "$TARGET/gtk-2.0"
mkdir -p "$TARGET/gtk-3.0"

printf "\nGenerating assets, this might take a while...\n"

# Generate assets
cp ./gtk2/_template ./gtk2/assets.svg
cp ./gtk3/_template ./gtk3/assets.svg
sed -i "s/_SEC_FG_COLOR/$SEC_FG_COLOR/g" ./gtk2/assets.svg ./gtk3/assets.svg
sed -i "s/_SEC_BG_COLOR/$SEC_BG_COLOR/g" ./gtk2/assets.svg ./gtk3/assets.svg
sed -i "s/_FG_COLOR/$FG_COLOR/g" ./gtk2/assets.svg ./gtk3/assets.svg
sed -i "s/_BG_COLOR/$BG_COLOR/g" ./gtk2/assets.svg ./gtk3/assets.svg
sed -i "s/_HIGHLIGHT_COLOR/$HIGHLIGHT_COLOR/g" ./gtk2/assets.svg ./gtk3/assets.svg
mkdir gtk2/assets 2> /dev/null
mkdir gtk3/assets 2> /dev/null
bash -c "cd gtk2 ; ./render-assets.sh"
bash -c "cd gtk3 ; ./render-assets.sh"

printf "\nFinishing up...\n"

# Copy assets to gtk2 folder
cp -r "./gtk2/assets" "$TARGET/gtk-2.0/assets"

# Copy assets to the gtk3 folder
cp -r "./gtk3/assets" "$TARGET/gtk-3.0/assets"

# Copy rc files to the gtk2 folder
cp "./gtk2/gtkrc" "$TARGET/gtk-2.0/"
cp "./gtk2/main.rc" "$TARGET/gtk-2.0/"
cp "./gtk2/menubar-toolbar.rc" "$TARGET/gtk-2.0/"

# Copy css file to the gtk3 folder
cp "./gtk3/gtk.css" "$TARGET/gtk-3.0/gtk.css"

# Set colors specified in config
sed -i "s/_SEC_FG_COLOR/$SEC_FG_COLOR/g" "$TARGET/gtk-2.0/gtkrc" "$TARGET/gtk-3.0/gtk.css"
sed -i "s/_SEC_BG_COLOR/$SEC_BG_COLOR/g" "$TARGET/gtk-2.0/gtkrc" "$TARGET/gtk-3.0/gtk.css"
sed -i "s/_FG_COLOR/$FG_COLOR/g" "$TARGET/gtk-2.0/gtkrc" "$TARGET/gtk-3.0/gtk.css"
sed -i "s/_BG_COLOR/$BG_COLOR/g" "$TARGET/gtk-2.0/gtkrc" "$TARGET/gtk-3.0/gtk.css"
sed -i "s/_HIGHLIGHT_COLOR/$HIGHLIGHT_COLOR/g" "$TARGET/gtk-2.0/gtkrc" "$TARGET/gtk-3.0/gtk.css"
