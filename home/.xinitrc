#!/bin/sh

export GTK2_RC_FILES="$HOME/.gtkrc-2.0" #is this still needed?
xsetroot -cursor_name left_ptr
xrdb -merge ~/.Xresources
setxkbmap de
xmodmap ~/.xmodmaprc
urxvtd -q -f -o
xset s off
xset -dpms
bgImg $(tail -n 1 ~/.fehbg | cut -d' ' -f 6-) &
#habak -mp 212,0 -hi '/home/ogion/bilder/Personen/amy_graine___master_of_white_magic_by_tjota-d8kqtsz.png'&
# i added these for gnome's evolution, which i'm not using at the moment, so..
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
#export SSH_AUTH_SOCK

unset LC_ALL
export LANG=de_DE.UTF-8
export LC_MESSAGES=C
export LC_TIME=de_DE.UTF-8

exec i3
