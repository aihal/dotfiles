#!/bin/sh

pingtest() {
ping -c 1 heise.de
}

while true
	do
		#pingtest && echo "Ping successful" && mpc toggle && break
                pingtest && DISPLAY=":0" zenity --info --text "ping erfolgreich" && break
		sleep 1
	done
