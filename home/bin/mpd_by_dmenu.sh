#!/bin/zsh
IFS='\t\n'

if [[ -f $HOME/.dmenurc ]]; then
  . $HOME/.dmenurc
else
  DMENU='dmenu -i'
fi

#if [ $# -eq 1 -a "$1" = "all" ]; then
#  mpc --no-status play $(mpc playlist --format '%title% by %artist%' | cut -c 2- | sed 's/)/ -/g' | $DMENU | awk '{print $1}')
#else
#  mpc --no-status play $(mpc playlist --format '%title% by %artist% #| %album%' | cut -c 2- | sed 's/)/ -/g' | grep -i "$*" | cut -d '|' -f 1 | $DMENU | awk '{print $1}')
#fi

if [[ $# -eq 1 -a "$1" = "all" ]]; then
  echo $(mpc playlist --format '%title% by %artist%' | cut -c 2- | sed 's/)/ -/g' | $DMENU | awk '{print $1}')
else
  echo $(mpc playlist --format '%title% by %artist% #| %album%' | cut -c 2- | sed 's/)/ -/g' | grep -i "$*" | cut -d '|' -f 1 | $DMENU | awk '{print $1}')
