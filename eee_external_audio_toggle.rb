#!/usr/bin/ruby
# coding: utf-8
# eee_external_audio_toggle.rb

case `ossmix jack.int-speaker.mode`.split.last
when "mix3"
    system("ossmix jack.int-speaker.mode mix2")
    system(%(echo "naughty.notify{ text='External audio is <span foreground=\\\"green\\\" >ON</span>', timeout = 3 }" | awesome-client))
when "mix2"
    system("ossmix jack.int-speaker.mode mix3")
    system(%(echo "naughty.notify{ text='External audio is <span foreground=\\\"red\\\" >OFF</span>', timeout = 3 }" | awesome-client))
end
