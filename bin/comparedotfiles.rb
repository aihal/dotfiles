#!/usr/bin/ruby
# comparing the files in my github repo with their originals

filehash = Hash.new
filehash = {
    '/home/ogion/github/dotfiles/xmodmaprc'            => '/home/ogion/.xmodmaprc',
    '/home/ogion/github/dotfiles/vimperatorrc'         => '/home/ogion/.vimperatorrc',
    '/home/ogion/github/dotfiles/vimperatorrc.local'   => '/home/ogion/.vimperatorrc.local',
    '/home/ogion/github/dotfiles/htoprc'               => '/home/ogion/.htoprc',
    '/home/ogion/github/dotfiles/fonts.conf'           => '/home/ogion/.fonts.conf',
    '/home/ogion/github/dotfiles/Xdefaults'            => '/home/ogion/.Xdefaults',
    '/home/ogion/github/dotfiles/zshrc'                => '/home/ogion/.zshrc',
    '/home/ogion/github/dotfiles/xinitrc'              => '/home/ogion/.xinitrc',
    '/home/ogion/github/dotfiles/vimrc'                => '/home/ogion/.vimrc',
    '/home/ogion/github/dotfiles/conkyrc'              => '/home/ogion/.conkyrc',
    '/home/ogion/github/dotfiles/xmobarrc'             => '/home/ogion/.xmobarrc',
    '/home/ogion/github/dotfiles/bin/autosuspend.sh' => '/home/ogion/bin/autosuspend.sh',
    '/home/ogion/github/dotfiles/bin/batteryalarm.sh' => '/home/ogion/bin/batteryalarm.sh',
    '/home/ogion/github/dotfiles/bin/checkdotfiles.pl' => '/home/ogion/bin/checkdotfiles.pl',
    '/home/ogion/github/dotfiles/bin/color_scheme.sh' => '/home/ogion/bin/color_scheme.sh',
    '/home/ogion/github/dotfiles/bin/colors.py' => '/home/ogion/bin/colors.py',
    '/home/ogion/github/dotfiles/bin/colors.sh' => '/home/ogion/bin/colors.sh',
    '/home/ogion/github/dotfiles/bin/conkystatbar.sh' => '/home/ogion/bin/conkystatbar.sh',
    '/home/ogion/github/dotfiles/bin/d20' => '/home/ogion/bin/d20',
    '/home/ogion/github/dotfiles/bin/dmenu_i3.sh' => '/home/ogion/bin/dmenu_i3.sh',
    '/home/ogion/github/dotfiles/bin/dwm_script.sh' => '/home/ogion/bin/dwm_script.sh',
    '/home/ogion/github/dotfiles/bin/eieruhr.sh' => '/home/ogion/bin/eieruhr.sh',
    '/home/ogion/github/dotfiles/bin/firefox_devshm.sh' => '/home/ogion/bin/firefox_devshm.sh',
    '/home/ogion/github/dotfiles/bin/gosleep' => '/home/ogion/bin/gosleep',
    '/home/ogion/github/dotfiles/bin/gosleep.sh' => '/home/ogion/bin/gosleep.sh',
    '/home/ogion/github/dotfiles/bin/i3statbar.sh' => '/home/ogion/bin/i3statbar.sh',
    '/home/ogion/github/dotfiles/bin/i3wsbar.sh' => '/home/ogion/bin/i3wsbar.sh',
    '/home/ogion/github/dotfiles/bin/make_script' => '/home/ogion/bin/make_script',
    '/home/ogion/github/dotfiles/bin/mostused_dmenu.sh' => '/home/ogion/bin/mostused_dmenu.sh',
    '/home/ogion/github/dotfiles/bin/mpd_by_dmenu.sh' => '/home/ogion/bin/mpd_by_dmenu.sh',
    '/home/ogion/github/dotfiles/bin/namegen.py' => '/home/ogion/bin/namegen.py',
    '/home/ogion/github/dotfiles/bin/ogidmenu.sh' => '/home/ogion/bin/ogidmenu.sh',
    '/home/ogion/github/dotfiles/bin/pingtester.sh' => '/home/ogion/bin/pingtester.sh',
    '/home/ogion/github/dotfiles/bin/pwc.pl' => '/home/ogion/bin/pwc.pl',
    '/home/ogion/github/dotfiles/bin/radio.pl' => '/home/ogion/bin/radio.pl',
    '/home/ogion/github/dotfiles/bin/rootterm' => '/home/ogion/bin/rootterm',
    '/home/ogion/github/dotfiles/bin/scrot_ogi.sh' => '/home/ogion/bin/scrot_ogi.sh',
    '/home/ogion/github/dotfiles/bin/trayer2' => '/home/ogion/bin/trayer2',
    '/home/ogion/github/dotfiles/bin/trayer3' => '/home/ogion/bin/trayer3',
    '/home/ogion/github/dotfiles/bin/watcher' => '/home/ogion/bin/watcher',
    '/home/ogion/github/dotfiles/bin/watcher.py' => '/home/ogion/bin/watcher.py',
    '/home/ogion/github/dotfiles/bin/watcher.sh' => '/home/ogion/bin/watcher.sh',
    '/home/ogion/github/dotfiles/bin/comparedotfiles.rb' => '/home/ogion/bin/comparedotfiles.rb',
    '/home/ogion/github/dotfiles/i3/config' => '/home/ogion/.i3/config',
    '/home/ogion/github/dotfiles/i3/dmenu' => '/home/ogion/.i3/dmenu',
    '/home/ogion/github/dotfiles/i3/dmenu_i3.sh' => '/home/ogion/.i3/dmenu_i3.sh',
    '/home/ogion/github/dotfiles/i3/i3log' => '/home/ogion/.i3/i3log',
    '/home/ogion/github/dotfiles/i3/i3statbar.sh' => '/home/ogion/.i3/i3statbar.sh',
    '/home/ogion/github/dotfiles/vim/colors/emg.vim' => '/home/ogion/.vim/colors/emg.vim',
    '/home/ogion/github/dotfiles/vim/colors/neverland.vim' => '/home/ogion/.vim/colors/neverland.vim',
    '/home/ogion/github/dotfiles/vim/colors/README.txt' => '/home/ogion/.vim/colors/README.txt',
    '/home/ogion/github/dotfiles/vim/doc/abolish.txt' => '/home/ogion/.vim/doc/abolish.txt',
    '/home/ogion/github/dotfiles/vim/doc/surround.txt' => '/home/ogion/.vim/doc/surround.txt',
    '/home/ogion/github/dotfiles/vim/doc/tags' => '/home/ogion/.vim/doc/tags',
    '/home/ogion/github/dotfiles/vim/ftdetect/pdc.vim' => '/home/ogion/.vim/ftdetect/pdc.vim',
    '/home/ogion/github/dotfiles/vim/ftdetect/tmux.vim' => '/home/ogion/.vim/ftdetect/tmux.vim',
    '/home/ogion/github/dotfiles/vimperator/colors/ogion.vimp' => '/home/ogion/.vimperator/colors/ogion.vimp',
    '/home/ogion/github/dotfiles/vim/plugin/abolish.vim' => '/home/ogion/.vim/plugin/abolish.vim',
    '/home/ogion/github/dotfiles/vim/plugin/gnupg.vim' => '/home/ogion/.vim/plugin/gnupg.vim',
    '/home/ogion/github/dotfiles/vim/plugin/repeat.vim' => '/home/ogion/.vim/plugin/repeat.vim',
    '/home/ogion/github/dotfiles/vim/plugin/surround.vim' => '/home/ogion/.vim/plugin/surround.vim',
    '/home/ogion/github/dotfiles/vim/syntax/ikiwiki.vim' => '/home/ogion/.vim/syntax/ikiwiki.vim',
    '/home/ogion/github/dotfiles/vim/syntax/mkd.vim' => '/home/ogion/.vim/syntax/mkd.vim',
    '/home/ogion/github/dotfiles/vim/syntax/nginx.vim' => '/home/ogion/.vim/syntax/nginx.vim',
    '/home/ogion/github/dotfiles/vim/syntax/pdc.vim' => '/home/ogion/.vim/syntax/pdc.vim',
    '/home/ogion/github/dotfiles/vim/syntax/rc9.vim' => '/home/ogion/.vim/syntax/rc9.vim',
    '/home/ogion/github/dotfiles/vim/syntax/rest.vim' => '/home/ogion/.vim/syntax/rest.vim',
    '/home/ogion/github/dotfiles/vim/syntax/tmux.vim' => '/home/ogion/.vim/syntax/tmux.vim',
    '/home/ogion/github/dotfiles/vim/syntax/vimperator.vim' => '/home/ogion/.vim/syntax/vimperator.vim',
    '/home/ogion/github/dotfiles/xmonad/xmonad.hs' => '/home/ogion/.xmonad/xmonad.hs'
}

filehash.each do |key,value|
    if `md5sum #{key} | cut -d ' ' -f 1` == `md5sum #{value} | cut -d ' ' -f 1`
        next
    else
        puts "#{value} #{key} md5sums do not match!"
        print "Do you want to see a vimdiff for those two files? [y/n] "
        system("vimdiff #{value} #{key}") if STDIN.gets.chomp == "y"
    end
end
