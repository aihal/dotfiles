#!/usr/bin/ruby
# coding: utf-8
# pingtester.rb

def pingtest
  ip = `host heise.de`.chomp.split.last
  if ip != "192.168.1.100"
    puts "Ping successful"
    exec("notify-send -u critical 'Pingtest successful'")
    exit 0
  end
  print "NoLuck "
end

while 0
  pingtest
  sleep 2
end
