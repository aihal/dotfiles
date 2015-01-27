#!/usr/bin/ruby
# coding: utf-8
# pingtester.rb

trap("INT") { exit 1 }

puts "still not perfect because host returns 0 even if error"
def pingtest
  ip = `host heisesss.de|head -n 1`.chomp.split.last
  puts ip
  if $?.success?
    if ip.start_with?("192.")
      #noluck
    else
      puts "Ping successful"
      exec("notify-send -u critical 'Pingtest successful'")
      exit 0
    end
  end#if $?.success? == false → noluck
  #print "NoLuck "
end

#counter=0
while true
  pingtest
  #counter+=1
  #print "on attempt " + counter.to_s + " "
  sleep 2
end
