#!/usr/bin/newlisp
# vim:ft=newlisp

(define (clean-whitespace x z)
; where x is a list of clipboard content lines
; and z is the joinchar, "" if we want to make a link, " " if we have a text
  (let ((y '()))
    (dolist (i x)
      (push (trim (replace {\s+} (copy i) z 0)) y -1))
   y)
)

(define (doit joinchar)
  (let ((clip (join (clean-whitespace (exec "xclip -o") joinchar) joinchar)))
    (exec "xclip -i" clip)))

(define (error)
  (begin
    (println {You need to supply an argument ("text" or "link" are supported)!})
      (exit 1)))

; set command to the cli args other than newlisp scriptname
(setq command (2 (main-args)))
; check if command is only "text" or "link", if else fail
(cond
  ((= "link" (join command "")) (doit ""))
  ((= "text" (join command "")) (doit " "))
  (true   (error))) ; if arg is something else

(exit)
