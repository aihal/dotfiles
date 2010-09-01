#!/bin/bash

#dmenu_i3
#Gazj 2010 garyjames82atgmaildotcom
#execute i3 commands using dmenu, history stored under ~/.i3/dmenu


GS=`cat ~/.i3/dmenu | dmenu  -fn fixed -nb '#100' -nf '#b9c0af' -sb '#000' -sf  '#afff2f' -i -p "i3 command:" $*`

if grep -q "$GS" "$HOME/.i3/dmenu" ; then
    echo already exists in history
else
    echo $GS >> ~/.i3/dmenu
fi

i3-msg $GS
