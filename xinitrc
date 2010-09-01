#!/bin/sh
#exec awesome

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
xsetroot -cursor_name left_ptr
xrdb ~/.Xdefaults
sh $HOME/.fehbg
#habak -mC ~/bilder/Wallpaper/wallpaper32.png&
setxkbmap de
xmodmap ~/.xmodmaprc
urxvtd -q -f -o


[[ -n $1 ]] && session=$1 || session=i3
case $session in
	xmonad) 
		(sleep 3; ~/bin/trayer2;xmodmap ~/.xmodmaprc; parcellite&)
		exec xmonad;;
	wmii)
		exec wmii;;
	i3)
		exec i3;;
	dwm)
		/home/ogion/bin/dwm_script.sh &
		exec dwm;;
	*)
		exec $session;;
esac
