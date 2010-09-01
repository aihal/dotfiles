#!/usr/bin/env python

fg = '\033[38;5;'
bg = '\033[48;5;'

cStrings=[]

for i in range( 0, 10):
  n = str(i)
  fgstr = '  ' + fg + n + 'm' + n + ' '
  bgstr = bg + n + 'm' 'XXX'
  cStrings.append(fgstr + bgstr + '\033[0m')

for i in range( 10, 100):
  n = str(i)
  fgstr = ' ' + fg + n + 'm' + n + ' '
  bgstr = bg + n + 'm' 'XXX'
  cStrings.append(fgstr + bgstr + '\033[0m')

for i in range( 100, 256):
  n = str(i)
  fgstr = fg + n + 'm' + n + ' '
  bgstr = bg + n + 'm' 'XXX'
  cStrings.append(fgstr + bgstr + '\033[0m')

x = 0
while x <= 26:
  print ' '.join(cStrings[x:256:27])
  x = x + 1
