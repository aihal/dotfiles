" Vim color file
" Maintainer:   Evan Gates <evan.gates@gmail.com>

" cool help screens
" :he group-name
" :he highlight-groups
" :he cterm-colors

set background=dark
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
    syntax reset
    endif
endif
let g:colors_name="emg"

" color terminal definitions
hi CursorColumn cterm=none ctermbg=232
hi CursorLine   cterm=none ctermbg=232

hi SpecialKey   ctermfg=darkgreen
hi NonText      cterm=bold ctermfg=darkblue
hi Directory    ctermfg=darkcyan
hi ErrorMsg     cterm=none ctermfg=7 ctermbg=1
hi IncSearch    cterm=NONE ctermfg=black ctermbg=yellow
hi Search       cterm=NONE ctermfg=black ctermbg=green
hi MoreMsg      ctermfg=darkgreen
hi ModeMsg      cterm=NONE ctermfg=brown
hi LineNr       ctermfg=3
hi Question     ctermfg=green

hi StatusLine   cterm=none ctermbg=18 ctermfg=87
hi StatusLineNC cterm=none ctermbg=17 ctermfg=66
hi TabLine      cterm=none ctermbg=17 ctermfg=66
hi TabLineFill  cterm=none ctermbg=17
hi TabLineSel   cterm=none ctermbg=18 ctermfg=87

hi VertSplit    ctermbg=17 ctermfg=17
hi Title        ctermfg=5
hi Visual       cterm=reverse
hi VisualNOS    cterm=bold,underline
hi WarningMsg   ctermfg=1
hi WildMenu     ctermfg=0 ctermbg=3
hi Folded       ctermfg=darkgrey ctermbg=NONE
hi FoldColumn   ctermfg=darkgrey ctermbg=NONE
hi DiffAdd      ctermbg=4
hi DiffChange   ctermbg=5
hi DiffDelete   cterm=bold ctermfg=4 ctermbg=6
hi DiffText     cterm=bold ctermbg=1

hi Comment  ctermfg=124

hi Constant  ctermfg=130
hi String    ctermfg=136
hi Character ctermfg=137
hi Number    ctermfg=131
hi Boolean   ctermfg=94
hi Float     ctermfg=95

hi Identifier cterm=none ctermfg=75
hi Function   cterm=none ctermfg=117

hi Special        ctermfg=161
hi SpecialChar    ctermfg=163
hi Tag            ctermfg=126
hi Delimiter      ctermfg=164
hi SpecialComment ctermfg=125
hi Debug          ctermfg=169

hi Statement   ctermfg=191
hi Conditional ctermfg=118
hi Repeat      ctermfg=40
hi Operator    ctermfg=154
hi Label       ctermfg=119
hi Keyword     ctermfg=184

hi PreProc   ctermfg=140
hi Include   ctermfg=141
hi Define    ctermfg=147
hi Macro     ctermfg=133
hi PreCondit ctermfg=97

hi Type         ctermfg=45
hi StorageClass ctermfg=36
hi Structure    ctermfg=50
hi Typedef      ctermfg=38

hi Underlined   cterm=underline ctermfg=5

hi Ignore   cterm=bold ctermfg=7
hi Ignore   ctermfg=darkgrey

hi Todo ctermbg=122

"vim: sw=4 ts=4
