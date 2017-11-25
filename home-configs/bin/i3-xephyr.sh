
#!/usr/bin/env zsh

function usage() {
    cat <<EOF
USAGE i3-xephyr start|stop|restart|run
start Start nested i3 in xephyr
stop Stop xephyr
restart reload i3 in xephyr
run run command in nested i3
EOF
}

function i3_pid() {
    /bin/pidof i3 | cut -d\ -f1
}

function xephyr_pid() {
    /bin/pidof Xephyr | cut -d\ -f1
}


[ $# -lt 1 ] && usage

I3=`which i3`
XEPHYR=`which Xephyr`

test -x $I3 || {echo "i3 executable not found."}
test -x $XEPHYR || {echo "Xephyr executable not found."}

case "$1" in
    start)
	$XEPHYR -ac -br -noreset -screen 800x600 :1 &
	sleep 1
	DISPLAY=:1.0 $I3 &
	sleep 1
	echo I3 ready for tests. PID is $(i3_pid)
	;;
    stop)
	echo -n "Stopping nested i3..."
	if [ -z $(xephyr_pid) ]; then
	    echo "Not running: not stopped :)"
	    exit 0
	else
	    kill $(xephyr_pid)
	    echo "Done."
	fi
	;;
    restart)
	echo -n "Restarting i3..."
	kill -s SIGHUP $(xephyr_pid)
	;;
    run)
	shift
	DISPLAY=:1.0 "$@" &
	;;
    *)
	usage
	;;
esac