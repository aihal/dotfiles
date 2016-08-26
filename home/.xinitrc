#!/bin/sh

export GTK2_RC_FILES="$HOME/.gtkrc-2.0" #is this still needed?
xsetroot -cursor_name left_ptr
xrdb -merge ~/.Xresources
setxkbmap de
xmodmap ~/.xmodmaprc
urxvtd -q -f -o
xset s off
xset -dpms
#bgImg $(tail -n 1 ~/.fehbg | cut -d' ' -f 6-) &
sh ~/.fehbg
xautolock -time 10 -locker /home/ogion/bin/startkiosk &

dunst&

unset LC_ALL
export LANG=de_DE.UTF-8
export LC_MESSAGES=C
export LC_TIME=de_DE.UTF-8

exec i3
