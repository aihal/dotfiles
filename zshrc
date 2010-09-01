################################################################################
# Mödified by Ogion
################################################################################


autoload -U colors && colors
if [[ $UID -eq 0 ]] ; then
    PS1="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%# "
else
    PS1="%{$fg[green]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg[yellow]%}%~ %{$reset_color%}%# "
fi

# ls colors
eval $(dircolors -b) 


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


export PATH=$PATH:~/bin
export PAGER="/bin/less"
autoload -U compinit
compinit
#promptinit

# {{{ 'hash' some often used directories
#d# start
hash -d doc=/usr/share/doc
hash -d log=/var/log
hash -d www=/var/www                                                                                            
hash -d builds=$HOME/builds
hash -d bin=$HOME/bin
#d# end
# }}}

 
### ZLE tweaks ###

## define word separators (for stuff like backward-word, forward-word, backward-kill-word,..)
#WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>' # the default
#WORDCHARS=.
WORDCHARS='*?_[]~=&;!#$%^(){}'
#WORDCHARS='${WORDCHARS:s@/@}'

setopt INTERACTIVE_COMMENTS
setopt nohup

# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000
setopt extended_history
setopt histignorealldups
setopt append_history autocd extendedglob nomatch notify
setopt noclobber
unsetopt beep

REPORTTIME=5       # report about cpu-/system-/user-time of command if running longer than 5 seconds

autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

## dont warn me about bg processes when exiting
setopt nocheckjobs

## alert me if something failed
setopt printexitvalue

## Allow comments even in interactive shells
#setopt interactivecomments


## compsys related snippets ##

## changed completer settings
#zstyle ':completion:*' completer _complete _correct _approximate
#zstyle ':completion:*' expand prefix suffix

## another different completer setting: expand shell aliases
#zstyle ':completion:*' completer _expand_alias _complete _approximate

## to have more convenient account completion, specify your logins:
#my_accounts=(
# {grml,grml1}@foo.invalid
# grml-devel@bar.invalid
#)
#other_accounts=(
# {fred,root}@foo.invalid
# vera@bar.invalid
#)
#zstyle ':completion:*:my-accounts' users-hosts $my_accounts
#zstyle ':completion:*:other-accounts' users-hosts $other_accounts

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


# }}}
_force_rehash()
{
    (( CURRENT == 1 )) && rehash
    return 1
}

if_not_loaded()                                                                                                 
{
    module=$(zmodload -L | grep $1) 
        
    if [[ -z $module ]]; then
        return 0
    else
        return 1
    fi  
}

################## COMPLETION ###################
#setopt always_to_end
#setopt complete_in_word
#setopt list_packed
#setopt no_menu_complete
#
#autoload -U compinit && compinit
#if_not_loaded zsh/complist && zmodload zsh/complist
#
## general completion technique
#zstyle ':completion:*' completer \
#    _force_rehash _complete _list _oldlist _expand _ignored _match \
#    _correct _approximate _prefix
#
## completion caching
#zstyle ':completion:*' use-cache 'yes'
#zstyle ':completion:*' cache-path ~/.zshcache
#
## completion with globbing
#zstyle ':completion:*' glob 'yes'
#
## selecting completion by cursor
#zstyle ':completion:*' menu select=long-list select=3
#
## colors in completion
#case $OSTYPE in
#    linux*)
#        eval $(dircolors)
#        ;;
#    freebsd*)
#        LS_COLORS=$colour
#        ;;
#esac
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#
## formatting and messages
#zstyle ':completion:*' verbose 'yes'
#zstyle ':completion:*:descriptions' format "%B-- %d --%b"
#zstyle ':completion:*:messages' format "%B--${green} %d ${nocolor}--%b"
#zstyle ':completion:*:warnings' format "%B--${red} no match for: %d ${nocolor}--%b"
#zstyle ':completion:*:corrections' format "%B--${yellow} %d ${nocolor}-- (errors %e)%b"
#zstyle ':completion:*' group-name ''
#
## show sections in manuals
#zstyle ':completion:*:manuals' separate-sections 'yes'
#
## describe options
#zstyle ':completion:*:options' description 'yes'
#zstyle ':completion:*:options' auto-description '%d' 


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

#



## aliases ##

## Normal aliases, added by Ogion

alias battery="cat /proc/acpi/battery/BAT0/state"
alias ..='cd ..'
alias ...='cd ../../'
alias cd..='cd ..'
alias cdd='cd /daten/'
alias cddd='cd /daten/pub/downloads/dc++/Downloads/'
alias cl='clear && l'
alias cll='clear&&ll'
alias cux='chmod u+x'
alias df='df -h'
alias du='du -h'
alias du0='du --max-depth 0'
alias du1='du --max-depth 1'
alias free='free -m'
alias m='man'
alias mplayer='mplayer -idx -fs -stop-xscreensaver -msgcolor -msgmodule'
alias psauxg='ps aux | grep -v grep | grep'
alias v='vim'
alias d="dict"
alias crontab='crontab -e'
alias cds='cd ~/music'
alias cdp='cd /home/rohan/programming/perl'
alias mpv='mpc volume'
alias cal='cal -m'
alias cdb='cd ~/books/Autoren'
alias toggle='mpc toggle'
alias next='mpc next'
alias ph='ping heise.de'
alias gpv=gpicview
alias p=pacman
alias s="slurpy -c"
alias c=clyde
alias grep="grep --color"
alias scpresume="rsync --partial --progress --rsh=ssh"
alias l='ls -CF --color=auto'
alias la='ls -aCF --color=auto'
alias ll="ls -lh --color=auto"
alias sshraku="ssh blackhat.endoftheinternet.org"
alias sshgont="ssh 192.168.0.1 -p 52222"
alias -s PDF="zathura"
alias -s pdf="zathura"
alias vimzshrc="vim ~/.zshrc"
alias vimvimrc="vim ~/.vimrc"
alias vimi3="vim ~/.i3/config"
alias vimxmonad="vim ~/.xmonad/xmonad.hs"
alias vimzitate="vim ~www/zim/Home/NetteZitate.t2t"
alias spu="sudo pacman -U"
alias xba="xbacklight"
alias qiv="qiv -Rfmi"
alias offlineimap='offlineimap -o'
alias perleval="perl -E 'say eval while<>'"

## Functions ##
zsh_stats() { history|awk '{print $2}'|grep -v zsh_stats|sort|uniq -c|sort -rn|head}
mcd() { [ -n "$1" ] && mkdir -p "$@" && cd "$1"; }
pacurl() { p -"$1" "$2" | grep "^URL" | sed -e 's/ //g' | cut -d ":" -f 2- | xclip -i }
slurpurl() { /usr/bin/slurpy "$1" "$2" | grep "^URL" | sed -e 's/ //g' | cut -d ":" -f 2- | xclip -i }
funfact() { wget randomfunfacts.com -qO- | sed -n "/<strong>/{s;^.*<i>\(.*\)</i>.*$;\1;p}" }
myip() { ifdata -pa "$1" }
speakermute() { ossmix jack.int-speaker.mute toggle }
xrandrvga1() { xrandr --output VGA1 --auto --right-of LVDS1 }
llg () { ls -lh --color=auto "$1" | grep -i "$2" }
showcolors() { for code in {0..255}; do echo -e "\e[38;05;${code}m $code: Test"; done }

vimwhich() { 
    which $1 && vim `which $1`
}
filewhich() { 
    which $1 && file `which $1`
}

vimrcconf() {
if [[ `whoami` == "root" ]]; then
        vim /etc/rc.conf
elif [[ `whoami` == "ogion" ]]; then
        sudo vim /etc/rc.conf
fi
}

rcd() {
if [[ `whoami` == "root" ]]; then
        /etc/rc.d/"$1" "$2"
elif [[ `whoami` == "ogion" ]]; then
        sudo /etc/rc.d/"$1" "$2"
fi
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
            *.rar)      unrar x $1          ;;
            *)          echo "'$1' Error. Please go away" ;;
            esac
            else
            echo "'$1' is not a valid file"
  fi
  }

# END FUNCTIONS


DIRSTACKSIZE=${DIRSTACKSIZE:-20}
DIRSTACKFILE=${DIRSTACKFILE:-${HOME}/.zdirs}

dirjump() {
    emulate -L zsh
    autoload -U colors
    local color=$fg_bold[blue]
    integer i=0
    dirs -p | while read dir; do
        local num="${$(printf "%-4d " $i)/ /.}"
        printf " %s  $color%s$reset_color\n" $num $dir
        (( i++ ))
    done
    integer dir=-1
    read -r 'dir?Jump to directory: ' || return
    (( dir == -1 )) && return
    if (( dir < 0 || dir >= i )); then
        echo d: no such directory stack entry: $dir
        return 1
    fi
    cd ~$dir
}


## miscellaneous code ##

## Some quick Perl-hacks aka /useful/ oneliner
#bew() { perl -le 'print unpack "B*","'$1'"' }
#web() { perl -le 'print pack "B*","'$1'"' }
#hew() { perl -le 'print unpack "H*","'$1'"' }
#weh() { perl -le 'print pack "H*","'$1'"' }
#pversion()    { perl -M$1 -le "print $1->VERSION" } # i. e."pversion LWP -> 5.79"
#getlinks ()   { perl -ne 'while ( m/"((www|ftp|http):\/\/.*?)"/gc ) { print $1, "\n"; }' $* }
#gethrefs ()   { perl -ne 'while ( m/href="([^"]*)"/gc ) { print $1, "\n"; }' $* }
#getanames ()  { perl -ne 'while ( m/a name="([^"]*)"/gc ) { print $1, "\n"; }' $* }
#getforms ()   { perl -ne 'while ( m:(\</?(input|form|select|option).*?\>):gic ) { print $1, "\n"; }' $* }
#getstrings () { perl -ne 'while ( m/"(.*?)"/gc ) { print $1, "\n"; }' $*}
#getanchors () { perl -ne 'while ( m/«([^«»\n]+)»/gc ) { print $1, "\n"; }' $* }
#showINC ()    { perl -e 'for (@INC) { printf "%d %s\n", $i++, $_ }' }
#vimpm ()      { vim `perldoc -l $1 | sed -e 's/pod$/pm/'` }
#vimhelp ()    { vim -c "help $1" -c on -c "au! VimEnter *" }

# key bindings

bindkey -e

#bindkey "\e[1~": beginning-of-line
#bindkey "\e[4~": end-of-line
#bindkey "\e[5~": beginning-of-history
#bindkey "\e[6~": end-of-history
#bindkey "\e[7~": beginning-of-line
#bindkey "\e[3~": delete-char
#bindkey "\e[2~": quoted-insert
#bindkey "\e[5C": forward-word
#bindkey "\e[5D": backward-word
#bindkey "\e\e[C": forward-word
#bindkey "\e\e[D": backward-word
#bindkey "\e[1;5C": forward-word
#bindkey "\e[1;5D": backward-word
#bindkey '5D' emacs-backward-word
#bindkey '5C' emacs-forward-word

#testing for urxvt
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[D" emacs-backward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e\e[C" emacs-forward-word
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line

# for inside tmux
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

# # for rxvt
#bindkey "\e[8~" end-of-line
#bindkey "\e[7~" beginning-of-line
# # for non RH/Debian xterm, can't hurt for RH/Debian xterm
#bindkey "\eOH" beginning-of-line
#bindkey "\eOF" end-of-line
# # for freebsd console
#bindkey "\e[H" beginning-of-line
#bindkey "\e[F" end-of-line
# # completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

bindkey  "\e[A"    history-search-backward
bindkey  "\e[B"    history-search-forward

#zle-keymap-select () {
#if [ $KEYMAP = vicmd ]; then
#echo -ne "\033]12;Red\007"
#else
#echo -ne "\033]12;Grey\007"
#fi
#}
#zle -N zle-keymap-select
#zle-line-init () {
#zle -K viins
#echo -ne "\033]12;Grey\007"
#}
#zle -N zle-line-init
#bindkey -v

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


## END OF FILE #################################################################
