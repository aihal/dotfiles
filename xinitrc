#!/bin/sh
#exec awesome

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
xsetroot -cursor_name left_ptr
#xrdb ~/.Xdefaults
#sh $HOME/.fehbg
#habak -mC ~/bilder/Wallpaper/wallpaper32.png&
setxkbmap de
xmodmap ~/.xmodmaprc
urxvtd -q -f -o
xset s off
xset -dpms


[[ -n $1 ]] && session=$1 || session=subtle
case $session in
	xmonad) 
		(sleep 3; ~/bin/trayer2;xmodmap ~/.xmodmaprc; parcellite&)
		exec xmonad;;
	dwm)
		/home/ogion/bin/dwm_script.sh &
		exec dwm;;
        subtle)
                sh $HOME/.fehbg
                exec subtle &> $HOME/.config/subtle/subtle-$(date +"%F-%k-%M").log;;
	*)
		exec $session;;
esac
