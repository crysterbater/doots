#!/bin/bash

NAME=$(cat "./index.theme" | grep "Name" | sed 's/.*=\(.*\)/\1/')
TARGET="/usr/share/themes/$NAME"

if [[ "$NAME" == "" ]]; then
    echo "Invalid Theme name."
    exit
fi

# Remove old directories
rm -rf "$TARGET"

# Create required directories
mkdir -p "$TARGET/gtk-3.0"
mkdir -p "$TARGET/gtk-2.0"

# Move theme info to the root theme dir
cp "./index.theme" "$TARGET/index.theme"

# Copy assets to the gtk3 folder
cp -r "./gtk3/assets" "$TARGET/gtk-3.0/assets"

# Copy css file to the gtk3 folder
cp "./gtk3/gtk.css" "$TARGET/gtk-3.0/gtk.css"

# Copy assets to gtk2 folder
cp -r "./gtk2/assets" "$TARGET/gtk-2.0/assets"
cp -r "./gtk2/menubar-toolbar" "$TARGET/gtk-2.0/menubar-toolbar"

# Copy rc files to the gtk2 folder
cp "./gtk2/gtkrc" "$TARGET/gtk-2.0/"
cp "./gtk2/main.rc" "$TARGET/gtk-2.0/"
