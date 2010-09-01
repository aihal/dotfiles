#!/bin/bash
# eieruhr - A small shell scipt that waits a specified length of time and then does mpc play
[[ $# -eq 0 ]] && echo "$(basename $0) usage: arg to be provided: Time (man 1 sleep)" && exit 1

NUMVAL=$(echo $1 | sed -e 's/[a-z].*//')
TIMEDESC=$(echo $1 | sed -e 's/[0-9]*//')

[[ ! -n $TIMEDESC ]] && TIMEDESC="s"

if [[ -e /home/ogion/mpd/mpd.pid ]]
 then 
  echo $(date)

   case $TIMEDESC in
    s) echo "Waiting $NUMVAL seconds...";;
    m) echo "Waiting $NUMVAL minutes...";;
    h) echo "Waiting $NUMVAL hours...";;
    d) echo "Waiting $NUMVAL days...";;
    *) echo "Please use a correct time designator (see man sleep)" && exit 1;;
   esac

  sleep $1 && mpc play >/dev/null
  echo $(date)
  echo "Time's up!" ; exit 0
 else
  echo "Please make sure mpd is running, idiot."
fi