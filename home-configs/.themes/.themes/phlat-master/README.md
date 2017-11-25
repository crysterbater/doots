Phlat is a simple, fast and daily usable dark theme mainly made for [Xfce](https://xfce.org) or [MATE](https://mate-desktop.org).

### Depends on: 

* GTK2 (mist, murrine and pixbuf engine with SVG support!)
* GTK3>=3.20
* Disabled GTK3 overlay scrollbars (export GTK_OVERLAY_SCROLLING=0)

### Recommends: 

* [GTK3-NOCSD](https://github.com/PCMan/gtk3-nocsd)
* [YAD](https://sourceforge.net/projects/yad-dialog)
* Xfce or MATE
* Chrome/Chromium(@GTK3)(any blink based browser will work due the internal styling of html forms)

### also included: 

* Xfce themes(XfDashboard, Balou, XfceNotifyd)
* WindowManager themes(Xfwm, Macro(Metacity/Muffin), Openbox, IceWM, Unity)
* Plank themes
* Chrome/Chromium Scrollbars
* Onboard theme
* A simple high contrast icon theme
* Qt5ct qgtkstyle qss fixes
* WinAMP 2.9x theme
* and more

## Install

For example to install it for all users:

```
## set your prefix usually /usr or /usr/local, 
## if unsure try: (getconf PATH|sed -e 's/\/bin//g;s/://g') 
prefix=/usr/local
## Base themes: GTK, GTK2, GTK3, Xfce, MATE, Openbox
mkdir /tmp/phlat && cd /tmp/phlat
wget https://github.com/sixsixfive/phlat/archive/master.zip
unzip master.zip
mkdir -p $prefix/share/themes
mv /tmp/phlat/phlat-master $prefix/share/themes/phlat
## HiDPI Base
ln -s $prefix/share/themes/phlat/@extra/phlat-hidpi $prefix/share/themes/phlat-HiDPI
## Icon theme
mkdir -p $prefix/share/icons
ln -s $prefix/share/themes/phlat/@extra/phlat-icons $prefix/share/themes/phlat
## IceWM
mkdir -p $prefix/icewm/themes
ln -s $prefix/share/themes/phlat/@extra/icewm/phlat $prefix/share/icewm/themes/phlat
## OnBoard
mkdir -p $prefix/onboard/themes
ln -s $prefix/share/themes/phlat/@extra/onboard/phlat.colors $prefix/share/onboard/themes/phlat.colors
ln -s $prefix/share/themes/phlat/@extra/onboard/phlat.theme $prefix/share/onboard/themes/phlat.theme
## Plank theme
mkdir -p $prefix/usr/share/plank/themes
ln -s $prefix/share/themes/phlat/@extra/plank/phlat $prefix/share/plank/themes/phlat
ln -s $prefix/share/themes/phlat/@extra/plank/phlat-full $prefix/share/plank/themes/phlat-full
## Qt5ct (if you use a different prefix than /usr you need to edit the image paths in phlat_QGtkStyle.qss)
mkdir -p $prefix/usr/share/qt5ct/qss
mkdir -p $prefix/usr/share/qt5ct/colors
ln -s $prefix/share/themes/phlat/@extra/qt5ct/colors/phlat_QGtkStyle.conf $prefix/usr/share/qt5ct/colors/phlat_QGtkStyle.conf
ln -s $prefix/share/themes/phlat/@extra/qt5ct/qss/phlat_QGtkStyle.qss $prefix/usr/share/qt5ct/qss/phlat_QGtkStyle.qss
## WinAMP theme(audacious example)
mkdir -p  $prefix/usr/share/audacious/Skins
ln -sf $prefix/share/themes/phlat/@extra/WinAMP/phlat $prefix/share/audacious/Skins/phlat
```
Chrome/Chromium theme:

just open chrome/chromium go to chrome://extensions/ enable developer mode and load the unpacked extension from:

```
$prefix/share/themes/phlat/@extra/Chromium_unpackedextension
```

Note: You have to symlink the subthemes instead of copying otherwise they might break!

### Packages

Packages for Debian, SuSE and Manjaro can be found on my [Opendesktop-page](https://www.opendesktop.org/s/XFCE/p/1175851/#files-panel).

## Optional

### Change hilight color

- If you want to change the default highlight color to something else(needs sed, tr and find!)

```
sh $prefix/share/themes/phlat/@extra/scripts/changecolor.sh 
```

or 

```
sh $prefix/share/themes/phlat/@extra/scripts/changecolor.sh -c "#16A085"
```

Remember that there is white text to display above that color(eg: on selections)

Some popular colors:

| Color | Description | Color | Description |
| :---: | :---: | :---: | :---: |
| ![#0088CC](https://placehold.it/150x80/0088CC/f1f2f2?text=0088CC) | Arch blue | ![#696969](https://placehold.it/150x80/696969/f1f2f2?text=696969) | Grey |
| ![#D70A53](https://placehold.it/150x80/D70A53/f1f2f2?text=D70A53) | Debian Red | ![#16A085](https://placehold.it/150x80/16A085/f1f2f2?text=16A085) | Manjaro Green |
| ![#6F6A83](https://placehold.it/150x80/6F6A83/f1f2f2?text=6F6A83) | Devuan Purple | ![#84563C](https://placehold.it/150x80/84563C/f1f2f2?text=84563C) | Caramel |
| ![#54487a](https://placehold.it/150x80/54487a/f1f2f2?text=54487A) | Gentoo Purple | ![#E95420](https://placehold.it/150x80/E95420/f1f2f2?text=E95420) | Ubuntu Orange |

### Set all themes

to set the whole theme you can run the following script (replace <$desktop> with mate or xfce!) eg:


```
sh $prefix/share/themes/phlat/@extra/scripts/set<$desktop>theme.sh
```

or:

```
sh $prefix/share/themes/phlat/@extra/scripts/set<$desktop>theme-hidpi.sh
```
