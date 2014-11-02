#!/bin/sh
#exec awesome

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
xsetroot -cursor_name left_ptr
xrdb -merge ~/.Xresources
#sh $HOME/.fehbg
#habak -mC ~/bilder/Wallpaper/wallpaper32.png&
setxkbmap de
xmodmap ~/.xmodmaprc
urxvtd -q -f -o
anamnesis --start
# config moved to ~/.config/dunst/dunstrc
# gets started automatically by dbus
#dunst &
#compton -cCGf -i 0.8 -e 0.8  --sw-opti -o 0.0 -D 3 &
xset s off
xset -dpms
#[[ -x /usr/bin/xautolock ]] && xautolock -time 50 -locker /usr/bin/i3lock -detectsleep &


[[ -n $1 ]] && session=$1 || session=i3
case $session in
  xmonad) 
    (sleep 3; ~/bin/trayer2;xmodmap ~/.xmodmaprc; parcellite&)
    exec xmonad;;

  dwm)
    /home/ogion/bin/dwm_script.sh &
    exec dwm;;

  subtle)
    sh $HOME/.fehbg
    exec subtle &> $HOME/.config/subtle/subtle-$(date +"%F-%H-%M").log;;

  herbstluftwm)
    exec herbstluftwm;;

  wmfs)
    sh /home/ogion/.fehbg &
    parcellite &
    conky -c ~/.wmfs2_status_conkyrc | while true; read line; do wmfs -c status "default $line"; done &
    exec wmfs;;

  i3)
    exec i3;;

  awesome)
    sh /home/ogion/.fehbg
    exec awesome -c /home/ogion/.config/awesome/rc.lua ;;

  *)
    sh $HOME/.fehbg
    exec $session;;

esac
