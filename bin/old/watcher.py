#!/usr/bin/python

import sys, re
from subprocess import call

try:
    sys.argv[1]
except:
    print "No program to watch defined"
    exit(1)
call(["clear"])
prog = sys.argv[1]

while 1:
    call([prog])
    eingabe = raw_input()
    if re.search(":q", eingabe):  
        exit(0)
    call(["clear"])
