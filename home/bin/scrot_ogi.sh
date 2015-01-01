#!/bin/sh
thisyear=$(date +"%Y")
[ ! -d ~/bilder/Screenshots/$thisyear ] && mkdir -p ~/bilder/Screenshots/$thisyear
sleep 0.03 && scrot '%Y-%m-%d-%H_%M_%S.png' -e "mv \$f ~/bilder/Screenshots/$thisyear/" && notify-send -t 1000 "screenshot taken" 
