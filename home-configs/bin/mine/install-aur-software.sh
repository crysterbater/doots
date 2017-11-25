#!/bin/bash

echo "################################################################"
echo ">>>>            Updating yaourt to the latest Packages  <<<<"
echo "################################################################"

yaourt -Syyu

echo "################################################################"
echo ">>>>             Your system & AUR is up to date          <<<<"
echo "################################################################"
echo "####"
echo "################################################################"
echo ">>>>                    Now Installing your Packages        <<<<"
echo ">>>>                        This May Take a While                 <<<<"
echo "################################################################"
sleep 1

yaourt -S --noconfirm --needed atom-editor-bin
yaourt -S --noconfirm --needed brackets
################################################################################################
#########                        Removing Conflicts with next installation
################################################################################################
sudo pacman -Rs compton conky
######################################################
yaourt -S --m-arg --skippgpcheck --noconfirm --needed compton-garnetius-git cava conky-nvidia conky-colors-git
yaourt -S --noconfirm --needed discord
yaourt -S --noconfirm --needed flatplat-blue-theme
yaourt -S --noconfirm --needed google-chrome grub-customizer grub2-theme-archlinux
yaourt -S --noconfirm --needed kupfer
yaourt -S --noconfirm --needed linux-steam-integration
yaourt -S --noconfirm --needed minecraft mintstick-git nerd-fonts-complete
yaourt -S --noconfirm --needed oranchelo-icon-theme-git
yaourt -S --noconfirm --needed paper-gtk-theme-git pycharm-community
read -n1 -rsp $' You are half way done Press any key to continue or Ctrl+C to exit...\n'
yaourt -S --m-arg --skippgpcheck --noconfirm --needed libopenssl-1.0-compat
yaourt -S --m-arg --skippgpcheck --noconfirm --needed libcurl-openssl-1.0
yaourt -S --noconfirm --needed spotify steam-fonts ttf-comic-neue ttf-ms-fonts
yaourt -S --noconfirm --needed vertex-icons-git vertex-themes vimix-icon-theme vimix-gtk-themes-git
yaourt -S --noconfirm --needed vivacious-colors-icon-theme
yaourt -S --noconfirm --needed x-tile-git xdo xdotool

echo "################################################################"
echo ">>>>                    AUR Packages are Installed        <<<<"
echo "################################################################"
echo "####"
echo "################################################################"
echo ">>>>            Removing Unnecessary Packages  <<<<"
echo "################################################################"
sleep 1

sudo pacman -Rs $(pacman -Qqdt)

echo "################################################################"
echo ">>>>           Unnecessary Packages Removed  <<<<"
echo "################################################################"
