#!/bin/bash

echo "###################################################################################"
echo "######## Will now Update and install Software #########"
echo "###################################################################################"
echo "####"
echo "################################################################"
echo ">>>>      Syncing Database & Updating to the latest Packages          <<<<"
echo "################################################################"

sudo pacman-optimize && sync
sudo pacman -Syyu

echo "################################################################"
echo ">>>>  Your system is now up to date                <<<<"
echo "################################################################"
read -n1 -rsp $' Update Successfull You May Want to Reboot Before Continuing Press any key to continue or Ctrl+C to exit...\n'

sudo pacman -S --noconfirm --needed audacity audacious audacious-plugins
sudo pacman -S --noconfirm --needed bleachbit breeze-icons
sudo pacman -S --noconfirm --needed cmatrix
sudo pacman -S --noconfirm --needed deluge dolphin-emu
sudo pacman -S --noconfirm --needed gnome-disk-utility gnome-system-monitor
sudo pacman -S --noconfirm --needed kodi kodi-addon-peripheral-joystick
sudo pacman -S --noconfirm --needed leafpad lib32-nvidia-utils lib32-libvdpau libvdpau libxnvctrl
sudo pacman -S --noconfirm --needed nvidia nvidia-settings nvidia-utils nvdock
sudo pacman -S --noconfirm --needed pcmanfm-gtk3
sudo pacman -S --noconfirm --needed screenfetch steam steam-native-runtime
sudo pacman -S --noconfirm --needed terminology virtualbox virtualbox-host-modules-arch
sudo pacman -S --noconfirm --needed xclip xorg-server-devel
################################################################################################
########                                 Removes virtual box modules
################################################################################################
sudo pacman -Rs  virtualbox-guest-modules-arch virtualbox-guest utils
################################################################################################
echo "################################################################"
echo ">>>>         core software installed                              <<<<"
echo "################################################################"
