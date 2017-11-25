exec Xephyr -screen 1366x752 -terminate -title "VirtualBox - Windows 7" :4 &
	xdotool search --classname "Xephyr" windowmove 0 16
	xdotool search --classname "Xephyr" windowsize 1366 752
	DISPLAY=:4 exec VirtualBox --startvm Hikari &
