killall compton
killall polybar
pkill dunst
i3-msg restart
launch-polybar
al-compositor --start
skippy-xd --config $HOME/.config/skippy-xd/skippy-xd.rc --start-daemon

sleep 0.5
notify-send "Config loaded" "{{.Name}}"
