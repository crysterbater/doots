#!/bin/bash

read -n1 -rsp $'This will Backup Files Specified Press Any Key to continue or Ctrl+C to exit...\n'

#############################################################################
#############################################################################
##########    This Will Handle Where All Files Will be Backed Up    ###############################
#############################################################################
external="/run/media/smoke/External/archlabs-backup/backup-and-restore/original"
#############################################################################
#############################################################################
#############################################################################

echo "################################################################"
echo "#########        Creating folders on External Drive       ##############"
echo "################################################################"
sleep 1

mkdir -p $external/config
mkdir -p $external/cache
mkdir -p $external/atom
mkdir -p $external/kodi
mkdir -p $external/local
mkdir -p $external/steam
mkdir -p $external/pycharm
mkdir -p $external/dont-starve
mkdir -p $external/minecraft
mkdir -p $external/home-folder-files
mkdir -p $external/firefox
mkdir -p $external/images
mkdir -p $external/gimp
mkdir -p $external/icons
mkdir -p $external/larian-studios
################################################################################################
##               Making User Home Directories on External Storage Device
################################################################################################
mkdir -p $external/home-folder-dirs
mkdir -p $external/home-folder-dirs/desktop
mkdir -p $external/home-folder-dirs/documents
mkdir -p $external/home-folder-dirs/downloads
mkdir -p $external/home-folder-dirs/music
mkdir -p $external/home-folder-dirs/pictures
mkdir -p $external/home-folder-dirs/videos
################################################################################################
##               Making SUDO Backup External Storage Directories
################################################################################################
mkdir -p $external/root-themes
mkdir -p $external/root-backgrounds
mkdir -p $external/applications
mkdir -p $external/misc-root
mkdir -p $external/root-themes/tint2
mkdir -p $external/misc-root/modprobe.d
mkdir -p $external/root-themes/grub
mkdir -p $external/root-themes/grub/icons

echo "################################################################"
echo "#########            Folders Successfully created            ################"
echo "################################################################"
##############################################################################################
########## This is the backup portion
##############################################################################################
echo "###################################################################################"
echo "#######   Will now find the specified folders and copy them to External Drive    ########"
echo "###################################################################################"
echo "###################################################################################"
echo "#####  Copying Config files to External Drive  #####"
echo "#####        This May Take a While      #####"
echo "###################################################################################"
sleep 2

### THIS WILL DELETE EVERYTHING in the backup folders  !!!   uncomment at your own risk    !!!    #################
# rm -rf  $external/cache
# rm -rf  $external/applications
# rm -rf  $external/atom
# rm -rf  $external/config
# rm -rf  $external/dont-starve
# rm -rf  $external/firefox
# rm -rf  $external/gimp
# rm -rf  $external/home-folder-dirs
# rm -rf  $external/home-folder-files
# rm -rf  $external/icons
# rm -rf  $external/images
# rm -rf $external/kodi
# rm -rf  $external/larian-studios
# rm -rf  $external/local
# rm -rf  $external/minecraft
# rm -rf $external/misc-root
# rm -rf  $external/pycharm
# rm -rf  $external/root-backgrounds
# rm -rf  $external/root-themes
# rm -rf  $external/steam
############# For wiping old unwanted backups Only ##########################
#################################################################
##               Copy options Used
## -r = recursive   -v = verbose   -u = update   -p = preserve
#################################################################
cp -r -v -u -p ~/.config/* $external/config/
cp -r -v -u -p ~/.cache/* $external/cache/
cp -r -v -u -p ~/.atom/* $external/atom/
cp -r -v -u -p ~/.kodi/* $external/kodi/
cp -r -v -u -p ~/.local/* $external/local/
cp -r -v -u -p ~/.PyCharmCE2017.1/* $external/pycharm/
cp -r -v -u -p ~/.klei/* $external/dont-starve/
cp -r -v -u -p ~/.minecraft/* $external/minecraft/
cp -r -v -u -p ~/.steam/* $external/steam/
############ best not to restore this one as may cause problems edit the file instead ##################################
cp -p -v -u -p ~/.* $external/home-folder-files/
##############################################################################################
cp -r -v -u -p ~/.mozilla/* $external/firefox/
cp -r -v -u -p ~/images/* $external/images/
cp -r -v -u -p ~/.gimp-2.8/* $external/gimp/
cp -r -v -u -p ~/.icons/* $external/icons/
cp -r -v -u -p ~/"Larian Studios"/* $external/larian-studios/
cp -r -v -u -p ~/Desktop/* $external/home-folder-dirs/desktop/
cp -r -v -u -p ~/Documents/* $external/home-folder-dirs/documents/
cp -r -v -u -p ~/Downloads/* $external/home-folder-dirs/downloads/
cp -r -v -u -p ~/Music/* $external/home-folder-dirs/music/
cp -r -v -u -p ~/Pictures/* $external/home-folder-dirs/pictures/
cp -r -v -u -p ~/Videos/* $external/home-folder-dirs/videos/
echo "###################################################################################"
echo "######## Removing Unwanted Home Directory File Backups  #########"
echo "###################################################################################"
sleep 1

rm -rf $external/home-folder-files/.x*
################################################################################################
#########         May want to comment theis line out to preserve Xresources colors etc.                     #############
##########     The restore portion will put them back properly if un commented

################################################################################################
rm -rf $external/home-folder-files/.X*
################################################################################################
rm -rf $external/home-folder-files/.z*
rm -rf $external/home-folder-files/.r*
rm -rf $external/home-folder-files/.w*
rm -rf $external/home-folder-files/.f*
rm -rf $external/home-folder-files/.I*
rm -rf $external/home-folder-files/.g*
rm -rf $external/home-folder-files/.e*
rm -rf $external/home-folder-files/.d*
################################################################################################
### #########                          SUDO Portion
################################################################################################
sudo cp -r -v -u -p /usr/share/themes/OB-* $external/root-themes/
sudo cp -v -u -p /usr/share/backgrounds/* $external/root-backgrounds/
sudo cp -v -u -p /usr/bin/screenfetch $external/applications/screenfetch
sudo cp -v -u -p /usr/share/applications/Kickshaw.desktop $external/applications/Kickshaw.desktop
sudo cp -v -p /etc/oblogout.conf $external/misc-root/oblogout.conf
sudo cp -v -p /etc/X11/xorg.conf $external/misc-root/xorg.conf
sudo cp -v -p /etc/modprobe.d/modprobe.conf $external/misc-root/modprobe.d/modprobe.conf
################################################################################################
############ best not to restore this one as may cause problems edit the file instead ##################################
################################################################################################
sudo cp -v -p /etc/mkinitcpio.conf $external/misc-root/mkinitcpio.conf
##############################################################################################
sudo cp -v -p /usr/share/tint2/nate-* $external/root-themes/tint2/
sudo cp -v -p /boot/grub/themes/Archlinux/archlogo.png  $external/root-themes/grub/archlogo.png
sudo cp -v -p /boot/grub/themes/Archlinux/icons/gnu-linux.png  $external/root-themes/grub/icons/gnu-linux.png
sudo cp -v -p /boot/grub/themes/Archlinux/icons/windows.png  $external/root-themes/grub/icons/windows.png
sudo cp -v -p /etc/default/grub $external/root-themes/grub/grub

echo "################################################################"
echo "###################    folders succesfully backed up  ################"
echo "################################################################"
