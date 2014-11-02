#!/usr/bin/ruby
# coding: utf-8
# countdown.rb

class Countdown
  def initialize
      @time = "1"
  end

  def wait
    @time = `yad --entry --entry-text="#{@time}" --entry-label="Set countdown time in minutes" --numeric`.chomp
    exit 0 if @time == ""
    puts "Sleeping for #{@time.to_f*60} seconds."
    sleep @time.to_f * 60
  end
end

my = Countdown.new
while true
  my.wait
  sleep 1
end
