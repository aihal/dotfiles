#!/usr/bin/ruby
# comparing the files in my github repo with their originals

filehash = Hash.new
filehash = {
    '/home/ogion/dotfiles/dotfiles/xmodmaprc'            => '/home/ogion/.xmodmaprc',
    '/home/ogion/dotfiles/dotfiles/vimperatorrc'         => '/home/ogion/.vimperatorrc',
    '/home/ogion/dotfiles/dotfiles/vimperatorrc.local'   => '/home/ogion/.vimperatorrc.local',
    '/home/ogion/dotfiles/dotfiles/htoprc'               => '/home/ogion/.htoprc',
    '/home/ogion/dotfiles/dotfiles/fonts.conf'           => '/home/ogion/.fonts.conf',
    '/home/ogion/dotfiles/dotfiles/Xdefaults'            => '/home/ogion/.Xdefaults',
    '/home/ogion/dotfiles/dotfiles/zshrc'                => '/home/ogion/.zshrc',
    '/home/ogion/dotfiles/dotfiles/xinitrc'              => '/home/ogion/.xinitrc',
    '/home/ogion/dotfiles/dotfiles/vimrc'                => '/home/ogion/.vimrc',
    '/home/ogion/dotfiles/dotfiles/conkyrc'              => '/home/ogion/.conkyrc',
    '/home/ogion/dotfiles/dotfiles/xmobarrc'             => '/home/ogion/.xmobarrc',
    '/home/ogion/dotfiles/dotfiles/bin/autosuspend.sh' => '/home/ogion/bin/autosuspend.sh',
    '/home/ogion/dotfiles/dotfiles/bin/batteryalarm.sh' => '/home/ogion/bin/batteryalarm.sh',
    '/home/ogion/dotfiles/dotfiles/bin/checkdotfiles.pl' => '/home/ogion/bin/checkdotfiles.pl',
    '/home/ogion/dotfiles/dotfiles/bin/color_scheme.sh' => '/home/ogion/bin/color_scheme.sh',
    '/home/ogion/dotfiles/dotfiles/bin/colors.py' => '/home/ogion/bin/colors.py',
    '/home/ogion/dotfiles/dotfiles/bin/colors.sh' => '/home/ogion/bin/colors.sh',
    '/home/ogion/dotfiles/dotfiles/bin/conkystatbar.sh' => '/home/ogion/bin/conkystatbar.sh',
    '/home/ogion/dotfiles/dotfiles/bin/d20' => '/home/ogion/bin/d20',
    '/home/ogion/dotfiles/dotfiles/bin/dmenu_i3.sh' => '/home/ogion/bin/dmenu_i3.sh',
    '/home/ogion/dotfiles/dotfiles/bin/dwm_script.sh' => '/home/ogion/bin/dwm_script.sh',
    '/home/ogion/dotfiles/dotfiles/bin/eieruhr.sh' => '/home/ogion/bin/eieruhr.sh',
    '/home/ogion/dotfiles/dotfiles/bin/firefox_devshm.sh' => '/home/ogion/bin/firefox_devshm.sh',
    '/home/ogion/dotfiles/dotfiles/bin/gosleep' => '/home/ogion/bin/gosleep',
    '/home/ogion/dotfiles/dotfiles/bin/gosleep.sh' => '/home/ogion/bin/gosleep.sh',
    '/home/ogion/dotfiles/dotfiles/bin/i3statbar.sh' => '/home/ogion/bin/i3statbar.sh',
    '/home/ogion/dotfiles/dotfiles/bin/i3wsbar.sh' => '/home/ogion/bin/i3wsbar.sh',
    '/home/ogion/dotfiles/dotfiles/bin/make_script' => '/home/ogion/bin/make_script',
    '/home/ogion/dotfiles/dotfiles/bin/mostused_dmenu.sh' => '/home/ogion/bin/mostused_dmenu.sh',
    '/home/ogion/dotfiles/dotfiles/bin/mpd_by_dmenu.sh' => '/home/ogion/bin/mpd_by_dmenu.sh',
    '/home/ogion/dotfiles/dotfiles/bin/namegen.py' => '/home/ogion/bin/namegen.py',
    '/home/ogion/dotfiles/dotfiles/bin/ogidmenu.sh' => '/home/ogion/bin/ogidmenu.sh',
    '/home/ogion/dotfiles/dotfiles/bin/pingtester.sh' => '/home/ogion/bin/pingtester.sh',
    '/home/ogion/dotfiles/dotfiles/bin/pwc.pl' => '/home/ogion/bin/pwc.pl',
    '/home/ogion/dotfiles/dotfiles/bin/radio.pl' => '/home/ogion/bin/radio.pl',
    '/home/ogion/dotfiles/dotfiles/bin/rootterm' => '/home/ogion/bin/rootterm',
    '/home/ogion/dotfiles/dotfiles/bin/scrot_ogi.sh' => '/home/ogion/bin/scrot_ogi.sh',
    '/home/ogion/dotfiles/dotfiles/bin/trayer2' => '/home/ogion/bin/trayer2',
    '/home/ogion/dotfiles/dotfiles/bin/trayer3' => '/home/ogion/bin/trayer3',
    '/home/ogion/dotfiles/dotfiles/bin/watcher' => '/home/ogion/bin/watcher',
    '/home/ogion/dotfiles/dotfiles/bin/watcher.py' => '/home/ogion/bin/watcher.py',
    '/home/ogion/dotfiles/dotfiles/bin/watcher.sh' => '/home/ogion/bin/watcher.sh',
    '/home/ogion/dotfiles/dotfiles/bin/comparedotfiles.rb' => '/home/ogion/bin/comparedotfiles.rb',
    '/home/ogion/dotfiles/dotfiles/i3/config' => '/home/ogion/.i3/config',
    '/home/ogion/dotfiles/dotfiles/i3/dmenu' => '/home/ogion/.i3/dmenu',
    '/home/ogion/dotfiles/dotfiles/i3/dmenu_i3.sh' => '/home/ogion/.i3/dmenu_i3.sh',
    '/home/ogion/dotfiles/dotfiles/i3/i3log' => '/home/ogion/.i3/i3log',
    '/home/ogion/dotfiles/dotfiles/i3/i3statbar.sh' => '/home/ogion/.i3/i3statbar.sh',
    '/home/ogion/dotfiles/dotfiles/vim/colors/emg.vim' => '/home/ogion/.vim/colors/emg.vim',
    '/home/ogion/dotfiles/dotfiles/vim/colors/neverland.vim' => '/home/ogion/.vim/colors/neverland.vim',
    '/home/ogion/dotfiles/dotfiles/vim/colors/README.txt' => '/home/ogion/.vim/colors/README.txt',
    '/home/ogion/dotfiles/dotfiles/vim/doc/abolish.txt' => '/home/ogion/.vim/doc/abolish.txt',
    '/home/ogion/dotfiles/dotfiles/vim/doc/surround.txt' => '/home/ogion/.vim/doc/surround.txt',
    '/home/ogion/dotfiles/dotfiles/vim/doc/tags' => '/home/ogion/.vim/doc/tags',
    '/home/ogion/dotfiles/dotfiles/vim/ftdetect/pdc.vim' => '/home/ogion/.vim/ftdetect/pdc.vim',
    '/home/ogion/dotfiles/dotfiles/vim/ftdetect/tmux.vim' => '/home/ogion/.vim/ftdetect/tmux.vim',
    '/home/ogion/dotfiles/dotfiles/vimperator/colors/ogion.vimp' => '/home/ogion/.vimperator/colors/ogion.vimp',
    '/home/ogion/dotfiles/dotfiles/vim/plugin/abolish.vim' => '/home/ogion/.vim/plugin/abolish.vim',
    '/home/ogion/dotfiles/dotfiles/vim/plugin/gnupg.vim' => '/home/ogion/.vim/plugin/gnupg.vim',
    '/home/ogion/dotfiles/dotfiles/vim/plugin/repeat.vim' => '/home/ogion/.vim/plugin/repeat.vim',
    '/home/ogion/dotfiles/dotfiles/vim/plugin/surround.vim' => '/home/ogion/.vim/plugin/surround.vim',
    '/home/ogion/dotfiles/dotfiles/vim/syntax/ikiwiki.vim' => '/home/ogion/.vim/syntax/ikiwiki.vim',
    '/home/ogion/dotfiles/dotfiles/vim/syntax/mkd.vim' => '/home/ogion/.vim/syntax/mkd.vim',
    '/home/ogion/dotfiles/dotfiles/vim/syntax/nginx.vim' => '/home/ogion/.vim/syntax/nginx.vim',
    '/home/ogion/dotfiles/dotfiles/vim/syntax/pdc.vim' => '/home/ogion/.vim/syntax/pdc.vim',
    '/home/ogion/dotfiles/dotfiles/vim/syntax/rc9.vim' => '/home/ogion/.vim/syntax/rc9.vim',
    '/home/ogion/dotfiles/dotfiles/vim/syntax/rest.vim' => '/home/ogion/.vim/syntax/rest.vim',
    '/home/ogion/dotfiles/dotfiles/vim/syntax/tmux.vim' => '/home/ogion/.vim/syntax/tmux.vim',
    '/home/ogion/dotfiles/dotfiles/vim/syntax/vimperator.vim' => '/home/ogion/.vim/syntax/vimperator.vim',
    '/home/ogion/dotfiles/dotfiles/xmonad/xmonad.hs' => '/home/ogion/.xmonad/xmonad.hs'
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
