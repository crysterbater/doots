
#!/bin/bash

cd /home/pringle/git/rice

rm -rf dots
mkdir dots
cd dots

cp ../.sendpyrc .

mkdir .config
mkdir .config/buku_run
mkdir .config/an2linux
mkdir .config/i3
mkdir .config/ranger
mkdir .config/rofi
mkdir .config/khard
mkdir .config/khal
mkdir .config/systemd
mkdir .config/systemd/user
mkdir .config/rofi-power
mkdir .config/rofi-pass
mkdir .config/roficlip
mkdir .config/powerline
mkdir .config/dunst
mkdir .config/zathura
mkdir .config/notes
mkdir .local
mkdir .local/share
mkdir .local/share/fonts
mkdir Pictures
mkdir Pictures/Wallpapers
mkdir .todo
mkdir .mpd
mkdir .mpd/playlists
mkdir .ncmpcpp
mkdir .vdirsyncer

cp -r /home/pringle/.mutt .mutt
cp /home/pringle/.vdirsyncer/config .vdirsyncer/.
cp /home/pringle/.extensions.bc .
cp /home/pringle/.vdirsyncer/getpass.sh .vdirsyncer/.
cp /home/pringle/.muttrc .muttrc
cp /home/pringle/.mailcap .mailcap
cp /home/pringle/.mpdconf .
cp /home/pringle/.rtorrent.rc .
cp /home/pringle/.mdlrc .
cp /home/pringle/.mdl_style.rb .
cp /home/pringle/.ncmpcpp/config .ncmpcpp/.
cp /home/pringle/.ncmpcpp/bindings .ncmpcpp/.
cp /home/pringle/.config/ranger/scope.sh .config/ranger/.
cp /home/pringle/.config/redshift.conf .config/.
cp /home/pringle/.config/ranger/rc.conf .config/ranger/.
cp -r /home/pringle/.config/dunst/dunstrc .config/dunst/.
cp -r /home/pringle/.notmuch-config .
cp -r /home/pringle/.config/zathura/zathurarc .config/zathura/.
cp -r /home/pringle/.config/khard/khard.conf .config/khard/.
cp -r /home/pringle/.config/khal/config .config/khal/.
cp -r /home/pringle/.config/notes/config .config/notes/.
cp -r /home/pringle/.config/i3/* .config/i3/
cp -r /home/pringle/.config/buku_run/* .config/buku_run/
cp -r /home/pringle/.config/rofi/* .config/rofi/
cp -r /home/pringle/.config/an2linux/config .config/an2linux/.
cp -r /home/pringle/.config/systemd/user/* .config/systemd/user/.
cp -r /home/pringle/.config/rofi-power/* .config/rofi-power/
cp -r /home/pringle/.config/rofi-pass/* .config/rofi-pass/
cp -r /home/pringle/.config/roficlip/* .config/roficlip/
cp -r /home/pringle/.todo/* .todo/
cp -r /home/pringle/.grc .
cp -r /home/pringle/.config/powerline/* .config/powerline
cp -r /home/pringle/.local/share/fonts .local/share/.
cp -r /home/pringle/.oh-my-zsh .
cp -r /home/pringle/.vim .
cp /home/pringle/Pictures/Wallpapers/solarizedcomputer.jpg Pictures/Wallpapers/.
cp -r /home/pringle/scripts .
cp -r /home/pringle/bin .
cp -r /home/pringle/.fonts.conf .
cp -r /home/pringle/.gtkrc-2.0 .
cp -r /home/pringle/.vimrc .
cp -r /home/pringle/.Xresources .
cp -r /home/pringle/.zshrc .
cp -r /home/pringle/.zprofile .
cp -r /home/pringle/.editorconfig .
cp -r /home/pringle/.dircolors.256dark .
cp -r /home/pringle/.offlineimaprc .
cp -r /home/pringle/.offlineimap.py .
