#!/usr/bin/ruby
# coding: utf-8
# eee_external_audio_toggle.rb

case `ossmix jack.int-speaker.mode`.split.last
when "mix3"
    system("ossmix jack.int-speaker.mode mix2")
    system(%Q(notify-send "toggle speakers" 'Built-in speakers are ON'))
when "mix2"
    system("ossmix jack.int-speaker.mode mix3")
    system(%Q(notify-send "toggle speakers" 'Built-in speakers are OFF'))
end
