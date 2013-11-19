" Vim syntax file
" Language: i3-wm config file
" Maintainer: Emanuel Guével
" Latest Revision: 16 October 2012

if exists("b:current_syntax")
  finish
endif

" Symbols
syn match   i3Operators "+\|→"
syn match   i3ChainDelimiter ";"

syn match   i3Var "\$\w\+"

" Key modifiers
syn keyword i3KeyModifier Shift Control Mod1 Mod2 Mod3 Mod4 Mod5

" Strings
syn region  i3SimpleString keepend start='[^ \t]' end='$\|;' contained contains=i3ChainDelimiter,i3Var
syn match   i3QuotedString '"[^"]\+"' contained
syn cluster i3String contains=i3SimpleString,i3QuotedString

" Config commands
syn keyword i3ConfigCommand bind bindcode bindsym assign new_window popup_during_fullscreen font floating_modifier default_orientation workspace_layout for_window focus_folows_mouse bar position colors output tray_output workspace_buttons
syn match   i3IpcSocket "ipc-socket" nextgroup=@i3String skipwhite

" Command keywords
syn keyword i3Command exit reload restart kill fullscreen global layout border focus move open split append_layout mark resize grow shrink restore show
syn keyword i3Param 1pixel default stacked tabbed normal none tiling stacking floating enable disable up down horizontal vertical up down left right parent child px or ppt leave_fullscreen toggle mode_toggle scratchpad width height top bottom client dock hide primary yes no all window container to
syn keyword i3WsSpecialParam next prev

" Exec commands
syn region  i3ExecCommand keepend start='[^ \t]' end='$\|;' contained contains=i3ChainDelimiter,i3Var
syn match   i3QuotedExecCommand '"[^"]\+"' contained
syn keyword i3ExecKeyword exec exec_always nextgroup=i3QuotedExecCommand,i3ExecCommand skipwhite

" Status command
syn match   i3StatusCommand ".*$" contained
syn keyword i3StatusCommandKeyword status_command nextgroup=i3StatusCommand skipwhite

" Font statement
syn keyword i3FontStatement font nextgroup=@i3String skipwhite

" Set statement
syn match   i3SetVar "\$\w\+" contained nextgroup=@i3String skipwhite
syn keyword i3SetKeyword set nextgroup=i3SetVar skipwhite

" Workspaces
syn keyword i3WsKeyword workspace nextgroup=i3WsSpecialParam,@i3String skipwhite

" Mode
syn keyword i3ModeKeyword mode nextgroup=@i3String skipwhite

" Comments
syn keyword i3Todo contained TODO FIXME XXX NOTE
syn match   i3Comment "#.*$" contains=i3Todo

" Error (at end of line)
syn match i3Error ".*$" contained

" Hex color code
syn match i3ColorLast "#[0-9a-fA-F]\{6\}" contained nextgroup=i3Error skipwhite
syn match i3Color2nd "#[0-9a-fA-F]\{6\}" contained nextgroup=i3ColorLast skipwhite
syn match i3Color1st "#[0-9a-fA-F]\{6\}" contained nextgroup=i3Color2nd skipwhite

syn match i3ColorDef1 "client\.background\|statusline\|background" nextgroup=i3ColorLast skipwhite
syn match i3ColorDef3 "client\.\(focused_inactive\|focused\|unfocused\|urgent\)\|inactive_workspace\|urgent_workspace\|focused_workspace\|active_workspace" nextgroup=i3Color1st skipwhite

highlight link i3ChainDelimiter       Operator
highlight link i3Operators            Operator

highlight link i3ExecCommand          Special
highlight link i3QuotedExecCommand    Special
highlight link i3StatusCommand        Special

highlight link i3Param                Constant
highlight link i3Color1st             Constant
highlight link i3Color2nd             Constant
highlight link i3ColorLast            Constant
highlight link i3WsSpecialParam       Constant

highlight link i3Var                  Identifier
highlight link i3SetVar               Identifier

highlight link i3KeyModifier          Function

highlight link i3SimpleString         String
highlight link i3QuotedString         String
highlight link i3WsName               String
highlight link i3QuotedWsName         String
highlight link i3SetValue             String
highlight link i3Font                 String

highlight link i3ExecKeyword          Keyword
highlight link i3Command              Keyword
highlight link i3WsKeyword            Keyword

highlight link i3ColorDef1            Define
highlight link i3ColorDef3            Define
highlight link i3ConfigCommand        Define
highlight link i3IpcSocket            Define
highlight link i3SetKeyword           Define
highlight link i3ModeKeyword          Define
highlight link i3FontStatement        Define
highlight link i3StatusCommandKeyword Define

highlight link i3Todo                 Todo
highlight link i3Comment              Comment
highlight link i3Error                Error
