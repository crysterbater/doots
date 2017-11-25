#! /bin/bash

track=`echo "$@"`
music='/home/lnk/Music/'
video='/home/lnk/Videos/'

ffmpeg -i "$video$track".mp4 -acodec libmp3lame -ab 160k -ar 44100 -ac 2 "$music$track".mp3
