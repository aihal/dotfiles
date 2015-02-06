" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimcurrent/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! archlinux.vim


" For more option refer to /usr/share/vim/vimcurrent/vimrc_example.vim or the
" vim manual

autocmd!
au BufNewFile,BufRead PKGBUILD set ft=sh
au BufNewFile,BufRead *.wiki set ft=creole
au BufNewFile,BufRead *.t2t set ft=txt2tags
au BufNewFile,BufRead *.thor set ft=ruby
au BufNewFile,BufRead *.slim set ft=slim
au BufRead,BufNewFile /usr/local/nginx/conf/* set ft=nginx 
au BufNewFile,BufRead *conkyrc set ft=conkyrc
au FileType pl,pm set filetype=perl
au BufNewFile,BufRead *.asciidoc colorscheme zenburn | set ft=asciidoc | set textwidth=80
au BufNewFile,BufRead *.go set tabstop=8 | set noexpandtab
au BufNewFile,BufRead *.lua colorscheme zenburn
au BufNewFile,BufRead *.lsp set ft=newlisp
au BufNewFile,BufRead *.nim set ft=nimrod

"au BufWritePost /tmp/xclipboardvim :%y+ | :!sleep 1
au BufWritePost /tmp/xclipboardvim exec '!xclip -i /tmp/xclipboardvim' | :!sleep 1
"" example for calling an external command as a post-write hook
"au BufWritePost /home/ogion/test/vimbla :!mpc toggle


""neverland doesn't work quite right in tmux, stupid terminals and their
""historical baggage
"set t_Co=265
set background=dark
colorscheme jellyx
"colorscheme neverland
filetype on
filetype plugin on
syntax on
set nonumber
set showcmd
set shortmess=aotTWI
set expandtab
set shiftwidth=2
set smarttab
set showmatch
set autoindent
set smartindent
set textwidth=0
"set cursorline
filetype plugin indent on

"set guioptions=aegirL
"set guioptions-=m
"set guioptions-=T

if has('gui_running')
  set background=light
  colorscheme lucius
  "colorscheme neverland
  set guicursor=a:blinkon0
  set guifont=DejaVu\ Sans\ Mono\ 10
  set guioptions-=T
  set guioptions+=g
  set guioptions-=t
  set guioptions-=m
  set guioptions-=L
  set guioptions-=l
  set guioptions-=r
  set guioptions-=R
  set guioptions-=a
endif
" stop visual mode from spamming X selection
set clipboard-=autoselect

" mappings...
"" ideas stolen from another vimrc
nnoremap <Space> :
" record little macros with qq, then play them with Q
nnoremap Q @q
" keep highlighting when doing indentation
vmap > >gv
vmap < <gv

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>
nmap <leader>x :!./%<cr>

" When vimrc is edited, reload it
autocmd! BufWritePost vimrc source ~/.vimrc

" Set 7 lines to the curors - when moving vertical..
set so=3

set wildmenu "Turn on WiLd menu

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase "Ignore case when searching
set smartcase
set nohlsearch "no Highlight search things
set incsearch "Make search act like search in modern browsers

set nolazyredraw "Don't redraw while executing macros

set magic "Set magic on, for regular expressions

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"set undodir=~/.vim/undodir
"set undofile

""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"""""""""""""""""""""""
