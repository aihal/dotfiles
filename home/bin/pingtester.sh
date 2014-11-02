#!/bin/sh

pingtest() {
ping -W 10 -c 1 heise.de
#host heise.de | cut -d ' ' -f 4
# heise.de = 193.99.144.80
}

while true
	do
		pingtest && echo "Ping successful" && notify-send -u CRITICAL "Pingtester" "Ping successful" && break
                #pingtest && DISPLAY=":0" zenity --info --text "ping erfolgreich" && break
		sleep 2
	done
