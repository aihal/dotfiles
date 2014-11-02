#!/bin/bash
# - gosleep.sh
isitmplayer="no"
isitmpd="no"
sleeptime="10m"

[[ -n $1 ]] && sleeptime=$1
mpc | sed -ne '2 p' | grep playing>/dev/null && isitmpd="yes"
pgrep mplayer>/dev/null && isitmplayer="yes"
echo "isitmpd set to $isitmpd"
echo "isitmplayer set to $isitmplayer"

sleep $sleeptime
[[ $isitmpd == "yes" ]] && mpc pause && ossvol -i 100
[[ $isitmplayer == "yes" ]] && echo "quit" >> /home/ogion/.mplayer/pipe && ossvol -i 100
