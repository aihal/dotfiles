#!/bin/bash
# do not use this without thinking about it
# (it requires an appropriate entry in fstab, like:
# /dev/shm/ogion/v065m7vx.default /home/ogion/.mozilla/firefox/v065m7vx.default bind noauto,user,exec,uid=1000,gid=100,bind 0 0
# ofc you have to edit the "ogion"s and stuff like that.
# (This is really just meant for me, 
# if someone wants to use it you'll have to adapt it.
STATIC="/home/ogion/.mozilla/firefox/profile_backup/"
TARGET="/home/ogion/.mozilla/firefox/v065m7vx.default/"
VOLATILE="/dev/shm/ogion/v065m7vx.default/"
PIDFILE="/dev/shm/ff/unpacked"

[[ -r $VOLATILE ]] || install -dm700 $VOLATILE

if mountpoint $TARGET;
then
    echo "Firefoxprofile already bound"
else
    mount $TARGET
fi

if [[ -e $PIDFILE ]]; then
  rsync -av $TARGET $STATIC
else
  rsync -av $STATIC $TARGET
  install -dm700 /dev/shm/ff
  touch $PIDFILE
fi
