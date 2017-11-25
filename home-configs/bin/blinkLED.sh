
#!/bin/sh
PORT=3
SLEEP=1
while true;
	do gpio disable $PORT
 	sleep $SLEEP
	gpio enable $PORT 
	sleep $SLEEP
done
