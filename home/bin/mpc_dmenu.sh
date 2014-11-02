#!/bin/bash
# - mpc_dmenu.sh

commands='add crop current del play next prev pause toggle stop clear shuffle move load save repeat random crossfade'

mpc $(echo $commands | sed -e 's/ /\n/g' | dmenu  -fn fixed -nb '#100' -nf '#b9c0af' -sb '#000' -sf  '#afff2f' -i -p "mpc ")
