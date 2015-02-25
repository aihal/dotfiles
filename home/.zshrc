################################################################################
# Mödified by Ogion
################################################################################

zmodload zsh/datetime
# history
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=100000
setopt extended_history
setopt histignorealldups
setopt inc_append_history autocd extendedglob nomatch notify
setopt noclobber
unsetopt beep

autoload -U colors && colors
if [[ $UID -eq 0 ]] ; then
    PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%# "
else
    PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%# "
fi

# ls colors
eval $(dircolors -b) 
export CLICOLOR=1


function zrcautoload() {
    emulate -L zsh
    setopt extended_glob
    local fdir ffile
    local -i ffound

    ffile=$1
    (( found = 0 ))
    for fdir in ${fpath} ; do
        [[ -e ${fdir}/${ffile} ]] && (( ffound = 1 ))
    done

    (( ffound == 0 )) && return 1
    if [[ $ZSH_VERSION == 3.1.<6-> || $ZSH_VERSION == <4->* ]] ; then
        autoload -U ${ffile} || return 1
    else
        autoload ${ffile} || return 1
    fi
    return 0
}

#
### Set window title
#

function set_title () {
    info_print  $'\e]0;' $'\a' "$@"
}

function info_print () {                                                                                        
    local esc_begin esc_end
    esc_begin="$1"
    esc_end="$2"
    shift 2
    printf '%s' ${esc_begin}
    for item in "$@" ; do 
        printf '%s ' "$item"
    done 
    printf '%s' "${esc_end}"
}


precmd() {
    case $TERM in
        (xterm*|rxvt*)
            set_title ${(%):-"%n@%m: %~"}
            ;;
    esac
}

##########

function homeshick() {
  if [ "$1" = "cd" ] && [ -n "$2" ]; then
    cd "$HOME/.homesick/repos/$2"
  else
    $HOME/.homesick/repos/homeshick/bin/homeshick "$@"
  fi
}
# This has to come before compinit for zsh to pick up homeshick completion
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

export PATH=$PATH:~/bin
export PAGER="/bin/less"
export EDITOR=vim
autoload -U compinit
compinit
#promptinit

# {{{ 'hash' some often used directories
#d# start
#example:
hash -d bin=$HOME/bin
hash -d tv=$HOME/video/tv
hash -d screens=$HOME/bilder/Screenshots/2015
#d# end
# }}}

 
### ZLE tweaks ###

## define word separators (for stuff like backward-word, forward-word, backward-kill-word,..)
#WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # the default
#WORDCHARS=.
#WORDCHARS='*?_[]~=&;!#$%^(){}'
#WORDCHARS='${WORDCHARS:s@/@}'
WORDCHARS='_-*~'

## Allow comments even in interactive shells
setopt INTERACTIVE_COMMENTS
## don't kill programs& if exiting the shell
setopt nohup
## dont warn me about bg processes when exiting
setopt nocheckjobs
## alert me if something failed
setopt printexitvalue

REPORTTIME=5       # report about cpu-/system-/user-time of command if running longer than 5 seconds

autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line


# {{{ completion system

    # allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

    # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*'       insert-unambiguous true
    zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
    zstyle ':completion:*:correct:*'       original true

    # activate color-completion
    zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

    # format on completion
    zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

    # complete 'cd -<tab>' with menu
    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*'        tag-order all-expansions
    zstyle ':completion:*:history-words'   list false

    # activate menu
    zstyle ':completion:*:history-words'   menu yes

    # ignore duplicate entries
    zstyle ':completion:*:history-words'   remove-all-dups yes
    zstyle ':completion:*:history-words'   stop yes

    # match uppercase from lowercase
    zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'

    # separate matches into groups
    zstyle ':completion:*:matches'         group 'yes'
    zstyle ':completion:*'                 group-name ''

    # if there are more than 5 options allow selecting from a menu
    zstyle ':completion:*'               menu select=5

    zstyle ':completion:*:messages'        format '%d'
    zstyle ':completion:*:options'         auto-description '%d'

    # describe options in full
    zstyle ':completion:*:options'         description 'yes'

    # on processes completion complete all user processes
    zstyle ':completion:*:processes'       command 'ps -au$USER'

    # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # provide verbose completion information
    zstyle ':completion:*'                 verbose true

    # recent (as of Dec 2007) zsh versions are able to provide descriptions
    # for commands (read: 1st word in the line) that it will list for the user
    # to choose from. The following disables that, because it's not exactly fast.
    zstyle ':completion:*:-command-:*:'    verbose false

    # set format for warnings
    zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

    # define files to ignore for zcompile
    zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
    zstyle ':completion:correct:'          prompt 'correct to: %e'

    # Ignore completion functions for commands you don't have:
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

    # Provide more processes in completion of programs like killall:
    zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

    # complete manual by their section
    zstyle ':completion:*:manuals'    separate-sections true
    zstyle ':completion:*:manuals.*'  insert-sections   true
    zstyle ':completion:*:man:*'      menu yes select

    # provide .. as a completion
    zstyle ':completion:*' special-dirs ..

    # run rehash on completion so new installed program are found automatically:
    _force_rehash() {
        (( CURRENT == 1 )) && rehash
        return 1
    }

    ## correction
    # try to be smart about when to use what completer...
    setopt correct
    zstyle -e ':completion:*' completer '
        if [[ $_last_try != "$HISTNO$BUFFER$CURSOR" ]] ; then
            _last_try="$HISTNO$BUFFER$CURSOR"
            reply=(_complete _match _ignored _prefix _files)
        else
            if [[ $words[1] == (rm|mv) ]] ; then
                reply=(_complete _files)
            else
                reply=(_oldlist _expand _force_rehash _complete _ignored _correct _approximate _files)
            fi
        fi'

    # command for process lists, the local web server details and host completion
    zstyle ':completion:*:urls' local 'www' '/var/www/' 'public_html'

    # caching
    [[ -d $ZSHDIR/cache ]] && zstyle ':completion:*' use-cache yes && \
                            zstyle ':completion::complete:*' cache-path $ZSHDIR/cache/


## }}} end completion system

### set colors for use in prompts
if zrcautoload colors && colors 2>/dev/null ; then 
    BLUE="%{${fg[blue]}%}"
    RED="%{${fg_bold[red]}%}"
    GREEN="%{${fg[green]}%}"
    CYAN="%{${fg[cyan]}%}"
    MAGENTA="%{${fg[magenta]}%}"
    YELLOW="%{${fg[yellow]}%}"
    WHITE="%{${fg[white]}%}"
    NO_COLOUR="%{${reset_color}%}"
else
    BLUE=$'%{\e[1;34m%}'
    RED=$'%{\e[1;31m%}'
    GREEN=$'%{\e[1;32m%}'
    CYAN=$'%{\e[1;36m%}'
    WHITE=$'%{\e[1;37m%}'
    MAGENTA=$'%{\e[1;35m%}'
    YELLOW=$'%{\e[1;33m%}'
    NO_COLOUR=$'%{\e[0m%}'
fi

### aliases

alias ..='cd ..'
alias ...='cd ../../'
alias cd..='cd ..'
alias cdscreens='cd ~/bilder/Screenshots/2015/'
alias cdtv="cd ~/video/tv/"
alias cux='chmod u+x'
alias df='df -h'
alias du='du -h'
alias du0='du --max-depth 0'
alias du1='du --max-depth 1'
alias free='free -m'
alias mpv='mpv --fs --stop-screensaver --msg-color --msg-module --no-osc --no-input-joystick --volume=100'
alias crontab='crontab -e'
alias ph='ping heise.de'
alias p=pacman
alias grep="grep --color"
alias l='ls -CF --color=auto'
alias la='ls -aCF --color=auto'
alias ll="ls -lh --color=auto"
#alias sshraku="ssh lolwut.nl"
alias  sshraku="ssh 94.213.236.128"
alias vimzshrc="vim ~/.zshrc"
alias vimvimrc="vim ~/.vimrc"
alias vimi3="vim ~/.i3/config"
alias vimzitate="vim /home/ogion/www/NetteZitate.asciidoc"
alias vimletsplayer="vim ~/documents/letsplayer"
alias rmflash='rm -Rf ~/.macromedia ~/.adobe'
alias spu="sudo pacman -U"
alias myrsync="rsync -avh --partial --progress"
alias sx="sxiv -f"
alias units="units -v"
alias wget="wget -c"
alias h=homeshick
#alias compton="compton -cCGf -i 0.8 -e 0.8  --sw-opti -o 0.0 -D 3 " # just an infodump
alias mv="mv -i"
alias rm="rm -i"
alias cp="cp -i"
alias gits="git status"

### Functions

yout() {
  youtube-dl $@ ; notify-send -u critical youtubedl
}

waitany() {
  while [[ ( -d /proc/$1 ) && ( -z `/usr/bin/grep zombie /proc/$1/status` ) ]]; do
    sleep 1
  done
}

plzs() {
  grep -i "$1" ~/bin/plz.csv
}

howmanyfiles() {
  find . -follow -maxdepth 1 -type f | wc -l
}

tclsh() {
  rlwrap -pBlue -m -q'"' tclsh $@
}

modifiedEtcFiles() {
  pacman -Qii 2>/dev/null | egrep "\<MODIFIED\>" | cut -f 2
}

psauxg() { ps aux | grep -v grep | grep "$@" }
  compdef _pgrep psauxg

mcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }
  compdef _mkdir mcd

myip() { ifdata -pa "$1" }

showcolors() { for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done }

countdeps() {
    LC_ALL=C pacman -Qi $1 | grep Required | sed -e 's/Required By    : \([a-z ]*\)/\1/' -e 's/  / /g' | wc -w
}

search() {
  pacman -Ss $@ ; lawr -s "$@"
}

vimwhich() { 
    which $1 && vim `which $1`
}
filewhich() { 
    which $1 && file `which $1`
}

whoowns() {
  pacman -Qo `which $1`
}

x () {
    if [ -f $1 ]; then
            case $1 in
            *.tar.bz2)  tar -jxvf $1        ;;
            *.tar.gz)   tar -zxvf $1        ;;
            *.tar.xz)   tar -axvf $1        ;;
            *.bz2)      bzip2 -d $1         ;;
            *.gz)       gunzip -d $1        ;;
            *.tar)      tar -xvf $1         ;;
            *.tgz)      tar -zxvf $1        ;;
            *.zip)      unzip $1            ;;
            *.Z)        uncompress $1       ;;
            *.7z)       7z e $1             ;;
            *.rar)      unrar x $1          ;;
            *)          echo "'$1' Error. Please go away" ;;
            esac
            else
            echo "'$1' is not a valid file"
  fi
}

### END FUNCTIONS

## key bindings

bindkey -e

## Pressing meta-y or ESC-y will input "yout $(xclip -o)" into the current commandline
yout-helper() {
  BUFFER="yout $(xclip -o | tr '\n' ' ')"
  CURSOR="$#BUFFER"
}
zle -N yout-helper
bindkey "^[y" yout-helper
youtube-helper() {
  local -a links
  links=($(xclip -o))
  # this seems hacky, is there a better way to wrap elements of an array in quotes?
  local i; for i in {1..$#links}; do links[$i]=\'$links[$i]\'; done; unset i
  BUFFER="yout -f 18 $links"
  CURSOR="$#BUFFER"
  unset links
}
zle -N youtube-helper
bindkey "^[Y" youtube-helper

bindkey "\eOd" emacs-backward-word
bindkey "\eOD" emacs-backward-word
bindkey "\e\e[D" emacs-backward-word
bindkey "\eOc" emacs-forward-word
bindkey "\eOC" emacs-forward-word
bindkey "\e\e[C" emacs-forward-word
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
## for inside tmux
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey '^i' expand-or-complete-prefix
bindkey  "\e[A"    history-search-backward
bindkey  "\e[B"    history-search-forward

#zle-keymap-select () {
#  if [ $KEYMAP = vicmd ]; then
#    echo -ne "\033]12;Red\007"
#  else
#    echo -ne "\033]12;Grey\007"
#  fi
#}
#zle -N zle-keymap-select
#zle-line-init () {
#  zle -K viins
#  echo -ne "\033]12;Grey\007"
#}
#zle -N zle-line-init
#bindkey -v
#bindkey '^r' history-incremental-search-backward

## support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

## zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
## colors for zsh-syntax-highlighting
ZSH_HIGHLIGHT_STYLES[default]='fg=cyan,bold' #base1
ZSH_HIGHLIGHT_STYLES[alias]='fg=white'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[function]='fg=white'
ZSH_HIGHLIGHT_STYLES[command]='fg=white'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=white'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=green,bold' #base01
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue,bold' #base0
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue,bold' #base0
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=red,bold' #orange

