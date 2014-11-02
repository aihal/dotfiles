#!/usr/bin/newlisp
#(let ((title (exec "mpc playlist | dmenu -i -l 10")))
(let ((title (exec "mpc playlist | rofi -dmenu -p 'Choose song: '")))
  (unless (empty? title)
    (! (string "mpc -q play " (+ (find (title 0) (exec "mpc playlist")) 1)))))
(exit)
