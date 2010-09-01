#!/bin/bash

if [[ $# -eq 0 ]]
then
    prog="/usr/bin/fortune"
else
    prog="$@"
fi

clear

while true
do
    input=yes
    clear
    $prog
    read input
    [[ $input =~ q ]] && break
done
