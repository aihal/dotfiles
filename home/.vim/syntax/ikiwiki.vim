" Vim syntax file
" Language:     Ikiwiki (links)
" Maintainer:   Recai Oktaş (roktasATdebian.org)
" Last Change:  2007 May 29

" Instructions:
"               - make sure to use the relevant syntax file which can be found
"                 at vim.org; below are the syntax files for markdown and reST,
"                 respectively:
"                 	http://www.vim.org/scripts/script.php?script_id=1242
"			http://www.vim.org/scripts/script.php?script_id=973
"               - put the file into your syntax directory (e.g. ~/.vim/syntax)
"               - if you use markdown (with .mdwn extension) add sth like below
"                 in your VIM startup file:
"                 	au BufNewFile,BufRead *.mdwn set ft=ikiwiki
"               - if you use a different markup other than markdown (e.g. reST)
"                 make sure to setup 'g:ikiwiki_render_filetype' properly in
"                 your startup file (skip this step for mkd.vim, it should work
"                 out of the box)
" Todo:
"               - revamp the whole file so as to detect valid ikiwiki directives
"                 and parameters (needs a serious work)

let s:cpo_save = &cpo
set cpo&vim

" Load the base syntax (default to markdown) if nothing was loaded.
if !exists("b:current_syntax")
	let s:ikiwiki_render_filetype = "mkd"
	if exists("g:ikiwiki_render_filetype")
		let s:ikiwiki_render_filetype = g:ikiwiki_render_filetype
	endif
	exe 'runtime! syntax/' . s:ikiwiki_render_filetype . '.vim'
endif

unlet b:current_syntax

syn case match

syn region ikiwikiLinkContent matchgroup=ikiwikiLink start=+\[\[\(\w\+\s\+\)\{,1}+ end=+\]\]+ contains=ikiwikiLinkNested,ikiwikiParam,ikiwikiNoParam
syn region ikiwikiLinkNested matchgroup=ikiwikiLinkNested start=+"""+ end=+"""+ contains=ikiwikiLinkContent contained

" FIXME: Below is an ugly hack to prevent highlighting of simple links
"        as directives.  Links with spaces are still problematic though.
syn region ikiwikiNoParam start=+\[\[[^|=]\+|+ end=+[^|=]\+\]\]+ keepend contains=ikiwikiMagic,ikiwikiDelim

syn match ikiwikiDelim "\(\[\[\|\]\]\)" contained
syn match  ikiwikiMagic "|" contained 
syn match  ikiwikiParam "\<\i\+\ze=" nextgroup=ikiwikiParamAssign contained
syn match  ikiwikiParamAssign "=" nextgroup=ikiwikiValue contained
syn region ikiwikiValue start=+"[^"]+hs=e-1 end=+[^"]"+ skip=+\\"+ keepend contains=ikiwikiValueMagic,ikiwikiDelim contained 
syn match  ikiwikiValueMagic +\(!\<\|\*\|\<\(and\|or\)\>\|\<\i*(\|\>)\)+ contained 

syn sync minlines=50

hi def link ikiwikiLink Statement
hi def link ikiwikiLinkNested String
hi def link ikiwikiLinkContent Underlined

hi def link ikiwikiMagic Operator
hi def link ikiwikiDelim Operator
hi def link ikiwikiNoParam Underlined
hi def link ikiwikiParam Identifier
hi def link ikiwikiParamAssign Operator
hi def link ikiwikiValue String
hi def link ikiwikiValueMagic Type

let b:current_syntax = "ikiwiki"
unlet s:cpo_save

" vim:ts=8:sts=8:noet
