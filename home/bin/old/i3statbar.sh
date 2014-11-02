#!/bin/dash

sleep_sec=1
#loops forever outputting a line every sleep_sec secs
while :; do
	statdate=$(date +"%d.%m.%Y %H:%M:%S")
	top=$(ps -eo pcpu,ucmd --sort -pcpu | sed -n 2,4p | awk '$1 > 10 {print $1 " (" $2 ") |"}')
	bat=$(acpi -b | awk '{ print $4 }' | sed -e 's/,//g')
	echo "$top ^i(/home/ogion/icons/robs_icons/dzen_bitmaps/battery.xbm) $bat | $statdate"
	sleep $sleep_sec
done | dzen2 -expand r -ta r -fn -*-profont-*-*-*-*-14-*-*-*-*-*-*-* -y 585 -x 250 # -w 800 
