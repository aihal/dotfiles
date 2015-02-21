#!/bin/sh

export GTK2_RC_FILES="$HOME/.gtkrc-2.0" #is this still needed?
xsetroot -cursor_name left_ptr
xrdb -merge ~/.Xresources
setxkbmap de
xmodmap ~/.xmodmaprc
urxvtd -q -f -o
anamnesis --start &
xset s off
xset -dpms
#sh /home/ogion/.fehbg &
habak -mp 144,0 -hi '/home/ogion/bilder/Personen/ea79a41584a6bae4c30ec6556cc1f25b.jpg' &

unset LC_ALL
export LANG=de_DE.UTF-8
export LC_MESSAGES=C
export LC_TIME=de_DE.UTF-8

exec i3
