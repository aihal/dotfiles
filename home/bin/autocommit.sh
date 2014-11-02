#!/bin/bash
# - autocommit.sh

IFS='	
'

[[ $1 ]] || exit 1

fullpath=$1

cd `dirname $fullpath` ; git commit -a -m "autocommit on file MODIFY: $fullpath"
notify-send "File `basename $fullpath` auto-commited in `dirname $fullpath`"
