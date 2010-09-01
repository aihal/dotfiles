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

au BufNewFile,BufRead *.t2t set ft=txt2tags
au BufRead,BufNewFile /usr/local/nginx/conf/* set ft=nginx 
"au BufNewFile,BufRead *.mdwn set ft=ikiwiki
au BufNewFile,BufRead *conkyrc set ft=conkyrc
au FileType pl,pm set filetype=perl

"colorscheme neverland
colorscheme emg
filetype on
filetype plugin on
set t_Co=265
syntax on
set nonumber
set showcmd
set shortmess=aotTWI
set ignorecase
set expandtab
set shiftwidth=4
set smarttab
set showmatch
set autoindent
set smartindent
set textwidth=0
"set cursorline
filetype plugin indent on
