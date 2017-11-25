pids=$(pidof tint2 | cut -d " " -f1,2)
pid=$(pidof xprop)

if [ -n $pid ]; then
	notify-send "$pid"
	kill $pid $pids
fi