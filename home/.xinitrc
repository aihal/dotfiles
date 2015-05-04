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
habak -mp 212,0 -hi '/home/ogion/bilder/Personen/amy_graine___master_of_white_magic_by_tjota-d8kqtsz.png'&

unset LC_ALL
export LANG=de_DE.UTF-8
export LC_MESSAGES=C
export LC_TIME=de_DE.UTF-8

exec i3
