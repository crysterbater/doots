#!/bin/bash
pause=1

while [ $pause == 1 ]
do
	echo "What would you like your username to be?"
	echo ""
	echo "Do NOT pick the name of an already existing user. This will overwrite their files!"
	echo ""
	echo "Pick a new username:"
	read USER
	read -p  "You have chosen $USER for your name. Are you sure? [y/N]" yn
	case $yn in
		[Yy]* ) pause=0 ;;
		[yes]* ) pause=0 ;;
		[Yes]* ) pause=0 ;;
	esac

done

useradd -m -g wheel -s /bin/bash $USER
passwd $USER
echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


pacman --noconfirm --needed -S base-devel xorg-xinit xorg-server termite feh ffmpeg pulseaudio pulseaudio-alsa arandr pavucontrol pamixer mpv wget rofi python-pip vim w3m ranger mediainfo poppler highlight tmux calcurse htop libqalculate newsbeuter moc network-manager-applet networkmanager firefox qutebrowser imagemagick transmission-cli atool libcaca xcompmgr transset-df blender pinta gimp texlive-most texlive-lang markdown mupdf evince audacity vim-latexsuite rsync youtube-dl youtube-viewer openssh syncthing noto-fonts-cjk noto-fonts-emoji cups screenfetch scrot unzip unrar biber ntfs-3g

systemctl enable NetworkManager
systemctl start NetworkManager

pip install netifaces psutil

curl http://lukesmith.xyz/longterm/luke2.sh > /home/$USER/luke2.sh

echo "root system configuration complete."
echo ""
echo "Now log out of root (ctrl-d), log in as $USER and run the following command:"
echo ""
echo "bash luke2.sh"
