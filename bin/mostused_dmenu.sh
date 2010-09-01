#!/bin/zsh
IFS=$'\t\n'
PATH=$PATH:/home/ogion/bin

mostused="firefox
conkystatbar.sh
sylpheed
ossxmix
vimprobable2
rootterm
gcolor2
jumanji
"

$(echo $mostused | dmenu -fn fixed -nb '#100' -nf '#b9c0af' -sb '#000' -sf  '#afff2f' -i)&
