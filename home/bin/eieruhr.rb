#!/usr/bin/ruby
# coding: utf-8
# vim: ft=ruby
# eieruhr

trap("SIGINT") { exit 1 }
require 'optparse'

options = { :seconds => 0.0 ,
            :minutes => 0.0 ,
            :hours => 0.0 ,
            :text => "Time's up¡",
            :nosound => false,
            :quiet => false }

parser = OptionParser.new do |opts|
  opts.banner = "eieruhr: waits for a specified amount of time and then starts music via mpd and gives a popup notification via notify-send (optionally yad). Requires: notify-send compatibility, mpd+mpc (plus a playlist called eieruhr)."
  opts.on("-h","--help","Display this help screen") {puts opts; exit 0}
  opts.on("-s","--seconds NUMBER",Float,'Wait for x seconds') {|s| options[:seconds] = s}
  opts.on("-m", "--minutes NUMBER", Float, 'Wait for x minutes') {|m| options[:minutes] = m}
  opts.on("--hours NUMBER", Float, 'Wait for x hours') {|h| options[:hours] = h}
  opts.on("-t", "--text TEXT", 'The text of the notification') {|text| options[:text] = text}
  opts.on("-n", "--nosound", "Don't start music") {options[:nosound] = true}
  opts.on("-q", "--quiet", "Don't output anything, don't notify") {options[:quiet] = true}
end

parser.parse!

class Eieruhr
  def initialize(x)
    @opts = x
    @title = "Eieruhr"

    @seconds = 0.0 + (@opts[:seconds]) + (@opts[:minutes]*60) + (@opts[:hours]*3600)

    @playlist = "eieruhr"
  end

  attr_accessor :seconds

  def sleepit
    # using the date command to get a localized version of the time
    system("date") unless @opts[:quiet]
    puts "Sleeping for " + @seconds.to_s + " seconds" unless @opts[:quiet]
    sleep @seconds
    system("date") unless @opts[:quiet]
  end

  def startmusic
    #`amixer set Speaker unmute`
    `mpc load #{@playlist}` if `mpc playlist` == ""
    `mpc play`
  end

  def notify_me
    system(%Q[notify-send -u critical -t 0 #{@title} "#{Time.new.strftime("%H:%M:%S")}: #{@opts[:text]} "])
  end

  def run
    sleepit
    startmusic unless @opts[:nosound]
    notify_me unless @opts[:quiet]
  end
end

my = Eieruhr.new(options)
if my.seconds <= 0.0
  puts "The total time has to be over 0 seconds"
  exit 1
end
my.run
