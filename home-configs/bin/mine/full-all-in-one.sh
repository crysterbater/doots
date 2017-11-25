#!/bin/bash

################################################################################################
#########                              This is the normal package installation
################################################################################################
echo "###################################################################################
######## Will now Update and install Software #########
###################################################################################
################################################################
>>>>      Syncing Database & Updating to the latest Packages          <<<<
################################################################"

sudo pacman-optimize && sync
sudo pacman -Syyu

echo "################################################################
>>>>          Your system is now up to date              <<<<
################################################################"
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
sudo pacman -Rs  virtualbox-guest-modules-arch virtualbox-guest-utils
################################################################################################
echo "################################################################
>>>>              core software installed                      <<<<
################################################################"

sleep 1
################################################################################################
#########                                 This is the AUR package installation
################################################################################################
echo "################################################################
>>>>          Updating yaourt to the latest Packages         <<<<
################################################################"

yaourt -Syyu

echo "################################################################
>>>>           Your system & AUR is up to date          <<<<
################################################################
################################################################
>>>>        Now Installing your Packages        <<<<
>>>>            This Will Take a While          <<<<
################################################################"
sleep 1

yaourt -S --noconfirm --needed atom-editor-bin
yaourt -S --noconfirm --needed brackets
################################################################################################
#########                        Removing  Software  Conflicts
################################################################################################
sudo pacman -Rs compton conky exo thunar thunar-volman thunar-archive-plugin
######################################################
yaourt -S --noconfirm --needed compton-garnetius-git cava conky-lua-nv conky-colors-git ## I find this compton works better
yaourt -S --noconfirm --needed discord thunar-gtk3 exo-devel
yaourt -S --noconfirm --needed flatplat-blue-theme
yaourt -S --noconfirm --needed google-chrome grub-customizer grub2-theme-archlinux
yaourt -S --noconfirm --needed kupfer
yaourt -S --noconfirm --needed linux-steam-integration
yaourt -S --noconfirm --needed minecraft mintstick-git nerd-fonts-complete
yaourt -S --noconfirm --needed oranchelo-icon-theme-git
yaourt -S --noconfirm --needed paper-gtk-theme-git pycharm-community
yaourt -S --m-arg --skippgpcheck --noconfirm --needed libopenssl-1.0-compat
yaourt -S --m-arg --skippgpcheck --noconfirm --needed libcurl-openssl-1.0
yaourt -S --noconfirm --needed spotify steam-fonts ttf-comic-neue ttf-ms-fonts
yaourt -S --noconfirm --needed vertex-icons-git vertex-themes vimix-icon-theme vimix-gtk-themes-git
yaourt -S --noconfirm --needed vivacious-colors-icon-theme
yaourt -S --noconfirm --needed x-tile-git xdo xdotool

echo "################################################################
>>>>                    AUR Packages are Installed           <<<<
################################################################
################################################################
>>>>          Removing Unnecessary Packages        <<<<
################################################################"
sleep 1

sudo pacman -Rs terminator deadbeef arandr lxrandr redshift
sudo pacman -Rs filezilla nmap hexchat chromium clipit-gtk3
sudo pacman -Rs transmission-gtk vivaldi-snapshot plank variety
sudo pacman -Rs bluez bluez-firmware bluez-utils bluez-tools pulseaudio-bluetooth blueberry gnome-bluetooth
sudo pacman -Rs system-config-printer gutenprint hplip cups-pdf
sudo pacman -Rs $(pacman -Qqdt)

echo "################################################################
>>>>           Unnecessary Packages Removed         <<<<
################################################################"
read -n1 -rsp $' Package Install Successfull Press any key to continue to Backup and Restore or Ctrl+C to exit...\n'

#############################################################################
#############################################################################
##########    This Will Handle Where All Files Will be Backed Up    ###############################
#############################################################################
external="/media/smoke/External/archlabs-backup/backup-and-restore"
#############################################################################
#############################################################################
#############################################################################

echo "################################################################
#########        Creating folders on External Drive       ##############
################################################################"
sleep 1
################################################################################################
##               Making User Home Directories on External Storage Device
################################################################################################
mkdir -p $external/home-folder-dirs
mkdir -p $external/home-folder-files
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

echo "################################################################
#########            Folders Successfully created            ################
################################################################"
##############################################################################################
########## This is the backup portion
##############################################################################################
echo "###################################################################################
#######   Will now find the specified folders and copy them to External Drive    ########
###################################################################################
###################################################################################
#####                     Copying Config files to External Drive  #####
#####                            This May Take a While        #####
###################################################################################"
sleep 2

### THIS WILL DELETE EVERYTHING in the backup folders  !!!   uncomment at your own risk    !!!    #################
# rm -rf  $external/applications
# rm -rf  $external/home-folder-dirs
# rm -rf  $external/home-folder-files
# rm -rf $external/misc-root
# rm -rf  $external/root-backgrounds
# rm -rf  $external/root-themes
############# For wiping old unwanted backups Only ##########################
#################################################################
##               Copy options Used
## -r = recursive   -v = verbose   -u = update   -p = preserve
#################################################################
cp -p -v -u ~/.* $external/home-folder-files/
cp -r -v -u -p ~/.icons .oh-my-zsh .mozilla .steam .klei .minecraft .PyCharmCE2017.1 .local .kodi .atom .cache .config $external/home-folder-dirs/
cp -r -v -u -p ~/Desktop Documents Downloads Pictures Videos images "Larian Studios" $external/home-folder-dirs/
#cp -r -v -u -p ~/Music/* $external/home-folder-dirs/music/
echo "###################################################################################
######## Removing Unwanted Home Directory File Backups  #########
###################################################################################"
sleep 1
################################################################################################
#########         May want to comment these lines out to preserve ZSH and Xterm colors etc.                     #############
#########            The restore portion will put them back properly if not commented  out                           #############
################################################################################################
#rm $external/home-folder-files/.X*
#rm -rf $external/home-folder-files/.z*
################################################################################################

rm $external/home-folder-files/.{x*,r*,w*,v*,f*,I*,g*,e*,d*}

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
############ best not to restore this one as may cause problems... edit the file instead ##################################
################################################################################################
sudo cp -v -p /etc/mkinitcpio.conf $external/misc-root/mkinitcpio.conf
##############################################################################################
sudo cp -v -p /usr/share/tint2/nate-* $external/root-themes/tint2/
sudo cp -v -p /boot/grub/themes/Archlinux/archlogo.png  $external/root-themes/grub/
sudo cp -v -p /boot/grub/themes/Archlinux/icons/{gnu-linux.png, windows.png}  $external/root-themes/grub/icons/
sudo cp -v -p /boot/grub/themes/Archlinux/icons/windows.png  $external/root-themes/grub/icons/windows.png
sudo cp -v -p /etc/default/grub $external/root-themes/grub/grub

echo "################################################################
###################    folders succesfully backed up  ################
################################################################"
################################################################################################
##########                                  This is the restore portion
################################################################################################
read -n1 -rsp $' Backup Successfull Press any key to continue to Restore and Swap Setup or Ctrl+C to exit...\n'
echo "##################################################################
########                                     Making Folders                                                               #########
##################################################################"
sleep 1

sudo mkdir /etc/modprobe.d

#######################################################################################
##########  Use These to Make a Symbolic Linked Folder to External Music   ###################################
#####                                            rm -rf  ~/Music                    															    ###################################
#####   ln -s /media/smoke/External/Music /home/smoke/Music                               ###################################
########################################################################################

echo "###################################################################################
######## Will now find the specified folders on External Drive and copy them to their respective folders #########
########                                    This May Take A While                                                 #########
###################################################################################"
sleep 1

cp -r -v -u -p $external/home-folder-files/* ~/
cp -r -v -u -p $external/home-folder-dirs/* ~/
#cp -r -v -u -p $external/home-folder-dirs/music/* ~/Music/  ### Using Symlink Instead
###########################################################################
###                       Root Portion
###########################################################################
sudo cp -r -v -u -p $external/root-themes/OB-* /usr/share/themes/
sudo cp -r -v -u -p $external/root-backgrounds/* /usr/share/backgrounds/
sudo cp -r -v -u -p $external/screenfetch /usr/bin/screenfetch
sudo cp -r -v -u -p $external/applications/Kickshaw.desktop /usr/share/applications/Kickshaw.desktop
sudo cp -r -v -p $external/misc-root/oblogout.conf /etc/oblogout.conf
sudo cp -r -v -u -p $external/misc-root/xorg.conf /etc/X11/xorg.conf
sudo cp -r -v -u -p $external/misc-root/modprobe.d/* /etc/modprobe.d/
############################################################################
###  sudo cp -r -v -p /run/media/smoke/External/archlabs-backup/backup-and-restore/misc-root/mkinitcpio.conf /etc/mkinitcpio.conf
############################################################################
sudo cp -r -v -p $external/root-themes/grub/* /boot/grub/themes/Archlinux/
sudo cp -r -v -p $external/root-themes/grub/grub /etc/default/grub

echo "################################################################
############   Files And Folders Succesfully Restored  ################
################################################################"
read -n1 -rsp $' Last Step is Swapfile Press any key to continue to Restore or Ctrl+C to exit...\n'
echo "################################################################
 >>>>           Making Swap File         <<<<
################################################################"
sleep 1
### M = megabytes    G = gigabytes
sudo fallocate -l 8192M /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile

echo "################################################################
>>>>          Swap File Successfully Created        <<<<
################################################################
##### use sudo nano /etc/fstab and make the changes #########
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a device; this may
# be used with UUID= as a more robust way to name devices that works even if
# disks are added and removed. See fstab(5).
#
# <file system>                           <mount point>  <type>  <options>  <dump>  <pass>
UUID=3A7B-175A                            /boot/efi      vfat    defaults,noatime 0       2
UUID=eb7bb970-8eb1-4952-b2d6-a2832badb63c /              ext4    defaults,noatime,discard 0       1
/swapfile                                 none           swap    defaults 0 0
UUID=3bc0e818-6727-4a9d-871a-2ed666dac733 /media/smoke/Storage ext4  defaults 0 0
UUID=DEBC8E9CBC8E6EB9                     /media/smoke/External ntfs defaults 0 0
tmpfs                                     /tmp           tmpfs   defaults,noatime,mode=1777 0       0
#######################################################################################
##########  Use These to Make a Symbolic Linked Folder to External Music   ###################################
#####                                            rm -rf  ~/Music                    															    ###################################
#####   ln -s /media/smoke/External/Music /home/smoke/Music                               ###################################
########################################################################################"
