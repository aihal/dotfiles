#!/bin/bash
# script to automatically suspend when battery low

batterystate=`acpi -b`
batterylevel=$(echo $batterystate | cut -d ' ' -f 4 | tr -d '%,')
chargestate=$(echo $batterystate | cut -d ' ' -f 3 | tr -d ',')

suspend_netbook() {
#    mpc stop
#    killall ossxmix
#    killall mplayer
#    soundoff
    sudo /root/ogisuspend.sh #&& soundon
}

if [[ $batterylevel -le 5 && $chargestate == "Discharging" ]]
then
    suspend_netbook
fi
