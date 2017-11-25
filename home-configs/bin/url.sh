#!/bin/bash

#which clipboard to use, valid options are "primary" and "clipboard"
SELECTION=xclip
#choose your terminal
TERM=sakura
shopt -s lastpipe

ops=(
    w3m
    mpv
    MPV
    youtube-dl
    YOUTUBE_DL
    transmission
    curl-download
    curl-save
    wget-saveall
    add-bookmark
)

getopts u: name
case $name in
u) url=$OPTARG ;;
*) url="$(xclip -o -selection $SELECTION)" ;;
esac

[[ ! $url ]] && exit
# to use with rofi ##
option=$(for i in "${ops[@]}"; do echo "$i"; done |  rofi -dmenu -location 1 -l 10 -width 100 -p : -font "Inconsolata 14" -mesg "open <u>$url</u> with...")
## uncomment below line to use with dmenu , and comment out line before this ##
# option=$(for i in "${ops[@]}"; do echo "$i"; done | /usr/bin/dmenu -b )

[[ ! $option ]] && exit

case "$option" in

w3m) $TERM -e w3m "$url" ;;
mpv) $TERM -e w3mpv "$url" ;;
MPV) $TERM -e mpv "$url"  ;;
youtube-dl) $TERM -e w3ytdl "$url" ;;
YOUTUBE-DL) $TERM -e youtube-dl "$url" ;;
## download torrent using transmission-cli
transmission) $TERM -e transmission-remote-cli "$url" ;;
## downlod with curl in current dir (home)
curl-download) $TERM -e curl -L -O --user-agent Mozilla/5.0 "$url" ;;
## save page as curl.html in Downloads
curl-save) $TERM -e curl -L -o ~/Downloads/curl.html --user-agent Mozilla/5.0 "$url" ;;
## save full page with wget, saved in Downloads
wget-saveall) $TERM -e wget --user-agent=Mozilla/5.0 --mirror -p --convert-links -P ~/Downloads "$url" ;;
# add bookmark
add-bookmark) 
	    echo -e "news\nlinux\ncycling\nsocial\nshopping\ntravel" | rofi -dmenu -location 1 -l 6 -width 100 -p : -font "Inconsolata 14" -mesg "choose tag for bookmark" | read tag
	    ## uncomment below for use with dmenu and comment out the upper line ##
	    # echo -e "news\nlinux\ncycling\nsocial\nshopping\ntravel" | /usr/bin/dmenu -fn "Inconsolata 14" -p "choose tag" | read tag
	    echo "$url $tag" >> ~/.config/lariza/bookmarks ;; 
## use any other external program chromium or firefox etc.
*) $option "$url" ;;
esac s
