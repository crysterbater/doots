#!/bin/bash

read -n1 -rsp $'Press any key to continue Restoring Files or Ctrl+C to exit...\n'
#############################################################################
#############################################################################
##########    This Will Handle Where All Files are Backed Up    ###############################
#############################################################################
external="/run/media/smoke/External/archlabs-backup/backup-and-restore/original"
#############################################################################
#############################################################################
#############################################################################
echo "###################################################################################"
echo "######## Making Directories if Needed #########"
echo "###################################################################################"
sleep 1

[ -d $HOME"/.steam" ] || mkdir -p $HOME"/.steam"
[ -d $HOME"/images" ] || mkdir -p $HOME"/images"
[ -d $HOME"/.atom" ] || mkdir -p $HOME"/.atom"
[ -d $HOME"/.kodi" ] || mkdir -p $HOME"/.kodi"
[ -d $HOME"/.cache" ] || mkdir -p $HOME"/.cache"
[ -d $HOME"/.mozilla" ] || mkdir -p $HOME"/.mozilla"
[ -d $HOME"/.PyCharmCE2017.1" ] || mkdir -p $HOME"/.PyCharmCE2017.1"
[ -d $HOME"/.klei" ] || mkdir -p $HOME"/.klei"
[ -d $HOME"/Larian Studios" ] || mkdir -p $HOME"/Larian Studios"
[ -d $HOME"/.local" ] || mkdir -p $HOME"/.local"
[ -d $HOME"/.minecraft" ] || mkdir -p $HOME"/.minecraft"
[ -d $HOME"/.gimp-2.8" ] || mkdir -p $HOME"/.gimp-2.8"
[ -d $HOME"/.icons" ] || mkdir -p $HOME"/.icons"
sudo mkdir /etc/modeprobe.d


echo "###################################################################################"
echo "######## Will now find the specified folders on External Drive and copy them to their respective folders #########"
echo "########                                    This May Take A While                                    #########"
echo "###################################################################################"
sleep 1

cp -r -v -p $external/config/*  ~/.config/
cp -r -v -p $external/cache/* ~/.cache/
cp -r -v -p $external/atom/* ~/.atom/
cp -r -v -p $external/kodi/* ~/.kodi/
cp -r -v -p $external/local/* ~/.local/
cp -r -v -p $external/steam/*  ~/.steam/
cp -r -v -p $external/pycharm/* ~/.PyCharmCE2017.1/
cp -r -v -p $external/dont-starve/* ~/.klei/
cp -r -v -p $external/minecraft/* ~/.minecraft/
# cp -r -v -p /run/media/smoke/External/archlabs-backup/backup-and-restore/home-folder-files/* ~/
cp -r -v -p $external/firefox/* ~/.mozilla/
cp -r -v -p $external/images/* ~/images/
cp -r -v -p $external/gimp/* ~/.gimp-2.8/
cp -r -v -p $external/icons/* ~/.icons/
cp -r -v -u -p $external/larian-studios/* ~/"Larian Studios"/
cp -r -v -u -p $external/home-folder-dirs/desktop/* ~/Desktop/
cp -r -v -u -p $external/home-folder-dirs/documents/* ~/Documents/
cp -r -v -u -p $external/home-folder-dirs/downloads/* ~/Downloads/
cp -r -v -u -p $external/home-folder-dirs/music/* ~/Music/
cp -r -v -u -p $external/home-folder-dirs/pictures/* ~/Pictures/
cp -r -v -u -p $external/home-folder-dirs/videos/* ~/Videos/
###########################################################################
###                       Root Portion
###########################################################################
sudo cp -r -v -p $external/root-themes/OB-* /usr/share/themes/
sudo cp -r -v -u -p $external/root-backgrounds/* /usr/share/backgrounds/
sudo cp -r -v -u -p $external/screenfetch /usr/bin/screenfetch
sudo cp -r -v -u -p $external/applications/Kickshaw.desktop /usr/share/applications/Kickshaw.desktop
sudo cp -r -v -p $external/misc-root/oblogout.conf /etc/oblogout.conf
sudo cp -r -v -p $external/misc-root/xorg.conf /etc/X11/xorg.conf
sudo cp -r -v -p $external/misc-root/modprobe.d/modprobe.conf /etc/modprobe.d/modprobe.conf
############################################################################
###  sudo cp -r -v -p /run/media/smoke/External/archlabs-backup/backup-and-restore/misc-root/mkinitcpio.conf /etc/mkinitcpio.conf
############################################################################
sudo cp -r -v -p $external/root-themes/grub/archlogo.png /boot/grub/themes/Archlinux/archlogo.png
sudo cp -r -v -p $external/root-themes/grub/icons/gnu-linux.png /boot/grub/themes/Archlinux/icons/gnu-linux.png
sudo cp -r -v -p $external/root-themes/grub/icons/windows.png /boot/grub/themes/Archlinux/icons/windows.png
sudo cp -r -v -p $external/root-themes/grub/grub /etc/default/grub

echo "################################################################"
echo "############   Files And Folders Succesfully Restored  ################"
echo "################################################################"
