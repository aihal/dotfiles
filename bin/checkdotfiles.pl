#!/usr/bin/perl

use common::sense;

my %filehash = (
    '/home/ogion/bitbucket/dotfiles/xmodmaprc'            => '/home/ogion/.xmodmaprc',
    '/home/ogion/bitbucket/dotfiles/vimperatorrc'         => '/home/ogion/.vimperatorrc',
    '/home/ogion/bitbucket/dotfiles/vimperatorrc.local'   => '/home/ogion/.vimperatorrc.local',
    '/home/ogion/bitbucket/dotfiles/htoprc'               => '/home/ogion/.htoprc',
    '/home/ogion/bitbucket/dotfiles/fonts.conf'           => '/home/ogion/.fonts.conf',
    '/home/ogion/bitbucket/dotfiles/Xdefaults'            => '/home/ogion/.Xdefaults',
    '/home/ogion/bitbucket/dotfiles/zshrc'                => '/home/ogion/.zshrc',
    '/home/ogion/bitbucket/dotfiles/xinitrc'              => '/home/ogion/.xinitrc',
    '/home/ogion/bitbucket/dotfiles/vimrc'                => '/home/ogion/.vimrc',
    '/home/ogion/bitbucket/dotfiles/conkyrc'              => '/home/ogion/.conkyrc',
    '/home/ogion/bitbucket/dotfiles/xmobarrc'             => '/home/ogion/.xmobarrc',
);

my @repofiles = keys %filehash;

foreach (@repofiles) {
    my $thisone = $_;
    print $thisone, " and ", $filehash{$thisone}, " do not have matching md5sums!\n" if (`md5sum $thisone | cut -d ' ' -f 1` ne `md5sum $filehash{$thisone} | cut -d ' ' -f 1`);
}
