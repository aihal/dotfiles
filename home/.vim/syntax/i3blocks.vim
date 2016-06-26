" Vim syntax file
" Language:	i3blocks.conf
" Maintainer:	Aihal (ogion Äŧ openmailbox.org)
" adapted from cfg syntax by Igor N. Prischepoff (igor@tyumbit.ru, pri_igor@mail.ru)
" Last change:	26.06.2016

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
    syntax clear
elseif exists ("b:current_syntax")
    finish
endif

" case off
syn case ignore
syn keyword i3blocksOnOff  ON OFF YES NO TRUE FALSE  contained
syn match UncPath "\\\\\p*" contained
"Dos Drive:\Path
syn match i3blocksDirectory "[a-zA-Z]:\\\p*" contained
"Parameters
syn match   i3blocksParams    ".\{0}="me=e-1 contains=i3blocksComment
"... and their values (don't want to highlight '=' sign)
syn match   i3blocksValues    "=.*"hs=s+1 contains=i3blocksDirectory,UncPath,i3blocksComment,i3blocksString,i3blocksOnOff

" Sections
syn match i3blocksSection	    "\[.*\]"
syn match i3blocksSection	    "{.*}"

" String
syn match  i3blocksString	"\".*\"" contained
syn match  i3blocksString    "'.*'"   contained

" Comments (Everything after '#' or '//')
syn match  i3blocksComment	"#.*"
syn match  i3blocksComment	"\/\/.*"

" Define the default hightlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_cfg_syn_inits")
    if version < 508
	let did_cfg_syn_inits = 1
	command -nargs=+ HiLink hi link <args>
    else
	command -nargs=+ HiLink hi def link <args>
    endif
    HiLink i3blocksOnOff     Label
    HiLink i3blocksComment	Comment
    HiLink i3blocksSection	Type
    HiLink i3blocksString	String
    HiLink i3blocksParams    Keyword
    HiLink i3blocksValues    Constant
    HiLink i3blocksDirectory Directory
    HiLink UncPath      Directory

    delcommand HiLink
endif
let b:current_syntax = "i3blocks"
" vim:ts=8
