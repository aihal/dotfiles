#!/bin/bash
# script sends alarm when battery low
#export DISPLAY=":0"
batterylevel=$(acpi -b | cut -d ' ' -f 4 | tr -d '%,')

battery_alarm() {
    #zenity --warning --text="Achtung Akku ist nur noch bei ${batterylevel}%"
    notify-send -t 0 "Batteryalarm" "Achtung: Akku nur noch bei ${batterylevel}%" -u CRITICAL
    #echo "naughty.notify{text=\"Achtung: Akku ist nur noch bei ${batterylevel}%\", fg=\"#F92672\", timeout=0}" | awesome-client
}

#[[ $batterylevel -le 15 ]] && battery_alarm

if [[ $batterylevel -le 15 ]]
then
    battery_alarm
fi
