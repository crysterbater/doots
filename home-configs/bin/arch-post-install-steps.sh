#!/bin/sh
set -e

echo ""
echo "Installing zsh..."
pacman -S --noconfirm zsh
sed -i s/'\(\/bin\/bash\)'/'\1\n\/bin\/zsh'/ /etc/shells

echo ""
echo "Creating a new user..."
echo ""
echo "Type in the new user login name:"
read user
useradd -m -g users -G wheel,uucp,rfkill,games -s /bin/zsh $user
passwd $user

echo ""
echo "Upgrading the system..."
pacman -Syu --noconfirm

echo ""
echo "Installing packages..."
echo "Installing base graphical system..."
pacman -S --noconfirm xorg-server xorg-server-utils xf86-video-vesa bspwm sxhkd lightdm lightdm-gtk-greeter

echo "Installing fonts..."
pacman -S --noconfirm ttf-bitstream-vera ttf-liberation ttf-ubuntu-font-family otf-fira-mono otf-ipafont terminus-font

echo "Installing necessary clis..."
pacman -S --noconfirm xdo jshon inotify-tools htop keychain fping xclip openssh network-manager-applet xdotool tree the_silver_searcher feh dosfstools gksu

echo "Installing sound related stuff..."
pacman -S --noconfirm alsa-utils pulseaudio pulseaudio-alsa

echo "Installing graphical utilitary applications..."
pacman -S --noconfirm lightdm-gtk-greeter-settings gparted gnome-screenshot gnome-calendar gnome-characters gnome-font-viewer gnome-sound-recorder thunar thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman ristretto cheese arandr lxappearance pavucontrol evince libreoffice-fresh dunst rofi

echo "Installing development stuff..."
pacman -S --noconfirm emacs termite git gvim neovim tmux ctags nodejs npm jre8-openjdk jdk8-openjdk python-neovim python2-neovim cmake

echo "Installing media stuff..."
pacman -S --noconfirm gimp vlc gst-plugins-ugly

echo "Installing libraries..."
pacman -S --noconfirm tlp networkmanager ntfs-3g xdg-user-dirs-gtk xarchiver unrar upower tumbler file-roller

echo "Installing web stuff..."
pacman -S --noconfirm chromium firefox transmission-gtk icedtea-web

echo "Installing eyecandy..."
pacman -S --noconfirm elementary-icon-theme

echo ""
echo "Setting up lightdm service..."
systemctl enable lightdm.service

echo ""
echo "Setting up NetworkManager service..."
systemctl enable NetworkManager.service

echo ""
echo "Setting up TLP..."
systemctl disable systemd-rfkill.service
systemctl enable tlp.service
systemctl enable tlp-sleep.service

echo ""
echo "The following commands will be run as the new added user"
sed -i s/'# \(%wheel ALL=(ALL) NOPASSWD: ALL\)'/'\1'/ /etc/sudoers

echo ""
echo "Installing package-query and yaourt from git..."
su - $user -c "git clone https://aur.archlinux.org/package-query && cd package-query/ && makepkg -sri"
su - $user -c "git clone https://aur.archlinux.org/yaourt && cd yaourt/ && makepkg -sri"
su - $user -c "rm -rf package-query/"
su - $user -c "rm -rf yaourt/"

echo ""
echo "Installing AUR packages..."
su - $user -c "yaourt -Syu --noconfirm"
su - $user -c "yaourt -S --noconfirm xss-lock prelink antigen-git chromium-widevine dunstify playerctl postman-bin spotify visual-studio-code gtk-theme-arc plex-media-server ttf-ms-fonts ttf-font-awesome unified-remote-server ffmpeg0.10"

echo ""
echo "Configuring npm global directory..."
su - $user -c "mkdir ~/.npm-global"
su - $user -c "echo \"prefix=~/.npm-global\" > ~/.npmrc"

echo ""
echo "Installing npm packages..."
su - $user -c "npm i -g yarn grunt-cli jsctags releasy tern typescript vtex diff-so-fancy"

echo ""
echo "Copying dotfiles..."
su - $user -c "git clone http://github.com/tamorim/dotfiles"
su - $user -c "cp -R dotfiles/* ."
su - $user -c "mkdir .vim/"
su - $user -c "cp -R .config/nvim/UltiSnips .vim/"

echo ""
echo "Installing Hack font..."
su - $user -c "mkdir .fonts && git clone https://github.com/powerline/fonts && mv fonts/Hack .fonts/Hack && rm -rf fonts"

echo ""
echo "Cloning tmux plugin manager..."
su - $user -c "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm"

echo ""
echo "Post installation done! Rebooting..."
sed -i s/'\(%wheel ALL=(ALL) NOPASSWD: ALL\)'/'# \1'/ /etc/sudoers
sed -i s/'# \(%wheel ALL=(ALL) ALL\)'/'\1'/ /etc/sudoers
sleep 5
reboot
