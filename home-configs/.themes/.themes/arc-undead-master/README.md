# Arc-Undead
#### A simplified GTK Arc Theme

Disclaimer: Credit for most of this goes to the original Arc Theme.
You can find it here: https://github.com/horst3180/arc-theme

### Installation

All you need to do to install this theme in its base configuration is running `install.sh` as root (or any other user that has access to `/usr/share/themes`) and the theme is ready to use.

### Hacking
This theme aims to be easy to configure and change. If you want to edit the gtk3 theme, you only have to edit the `gtk.css`.
For the gtk2 theme you'll have to edit the `gtkrc` file. Both gtk2 and gtk3 have an `assets.svg` file for the images.

There are only a few colors which have been used in the creation of this theme, these are:
 * `#1b1b1b` as primary background color
 * `#262626` as secondary background color
 * `#9e9e9e` as primary foreground color
 * `#616161` as secondary foreground color
 * `#752a2a` as highlight color

Once you change the `assets.svg` file you'll have to regenerate the assets using the `render-assets.sh` script.
This requires `inkscape` and optionally `optipng` for compressing the output images.

If you want to change the name of the theme, all you have to do is edit the `index.theme` file and replace every occurance of `Arc-Undead` with the new name.

After changing anything, you'll have to reinstall the theme using the `install.sh` script.

## Screenshots

### GTK3
![Screenshot](https://i.imgur.com/Q31AUIL.png)
![Screenshot](https://i.imgur.com/qND1ebX.png)

### GTK2
![Screenshot](https://i.imgur.com/oFcLy2y.png)
