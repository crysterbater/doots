#tint2 -c ~/Desktop/configs/workspace_switcher_background &
#sleep 0.1
#tint2 -c ~/Desktop/configs/workspace_switcher &
~/Desktop/tints.sh
sleep 5

xprop -root -spy _NET_CURRENT_DESKTOP | (
	while read line; do
		#~/Desktop/scripts/restore_wallpaper_numericly.sh
		~/Desktop/restore_wallpaper.sh
	done
)
