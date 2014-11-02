" Vim syntax file
" Language: Europa Universalis 3 config files

let b:current_syntax = "eu3"
if exists(b:current_syntax)
    finish
endif

syn match euComment "#.*$"

syn keyword euCountries THIS FROM

" eu3 commands/keywords/variables whatever
syn keyword euCommands trigger potential id
syn keyword euCommands allow effect tag
syn match   euCommands "ai_will_do"
syn match   euCommands "add_country_modifier"

" eu3 variables 
syn keyword euVars government prestige tag religion name duration factor MIL
syn match euVars "aristocracy_plutocracy"
syn match euVars "centralization_decentralization"
syn match euVars "has_country_modifier" 
"syn match euVars 
"syn match euVars 
"syn match euVars 
"syn match euVars 
"syn match euVars 
"syn match euVars 
"syn match euVars 
"syn match euVars 


syn match euOperator "="
syn keyword euOperator NOT AND OR

" Regular int like number with - + or nothing in front
syn match euNumber '\d\+'
syn match euNumber '[-+]\d\+'

" Floating point number with decimal no E or e (+,-)
syn match euNumber '\d\+\.\d*'
syn match euNumber '[-+]\d\+\.\d*'

" Floating point like number with E and no decimal point (+,-)
syn match euNumber '[-+]\=\d[[:digit:]]*[eE][\-+]\=\d\+'
syn match euNumber '\d[[:digit:]]*[eE][\-+]\=\d\+'

" Floating point like number with E and decimal point (+,-)
syn match euNumber '[-+]\=\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'
syn match euNumber '\d[[:digit:]]*\.\d*[eE][\-+]\=\d\+'

syn match   euBoolean        "\<\%(yes\|no\)\>"

syn match euString "\".*\""
"syn region euString start='"' end='"' contained

" linking the groups with highlighting rules
hi def link euComment Comment
hi def link euOperator Operator
hi def link euCountries Constant
hi def link euNumber Number
hi def link euBoolean Boolean
hi def link euCommands Keyword
hi def link euVars Identifier
hi def link euString String
