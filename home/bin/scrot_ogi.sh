#!/bin/dash
sleep 0.03 && scrot '%Y-%m-%d-%H_%M_%S.png' -e 'mv $f ~/bilder/Screenshots/2014/' && notify-send -t 1000 "screenshot taken" 
