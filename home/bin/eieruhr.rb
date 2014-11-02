#!/usr/bin/ruby
# coding: utf-8
# vim: ft=ruby
# eieruhr

trap("SIGINT") { exit 0 }
require 'slop'

opts = Slop.parse do
    on :s, :seconds=, 'Wait for x seconds', :optional => false, :as => :integer
    on :m, :minutes=, 'Wait for x minutes', :optional => false, :as => :Integer
    on :h, :hours=, 'Wait for x hours', :optional => false, :as => :Integer
    on :x, :type=, 'The type of notification'
    on :t, :text=, 'The text of the notification'
    on :n, :nosound, "Don't turn on sound, just show notification"
    on :q, :quiet, "Don't output anything"
    on :help, "Print help"
end

#if opts[:seconds].class and opts[:minutes].class and opts[:hours].class == NilClass
#  puts "At least one of seconds, minutes or hours has to be given an argument"
#  exit 1
#end

if opts[:help]
  puts "\
eieruhr: waits for a specified amount of time and then starts music via mpd and \
gives a popup notification via notify-send (optionally yad). Requires: \
notify-send compatibility, mpd+mpc (plus a playlist called eieruhr), oss."
  puts opts
  exit 0
end

class Eieruhr
    def initialize(slopts)
        @opts = slopts
        @message = @opts[:text] || "Time's up! "
        @title = "Eieruhr"
        @type = @opts[:type] || "notify-send"
        @nosound = @opts[:nosound] || false
        @quiet = @opts[:quiet] || false

        @seconds = 0
        @seconds += @opts[:seconds] if @opts[:seconds]
        @seconds += @opts[:minutes]*60 if @opts[:minutes]
        @seconds += @opts[:hours]*3600 if @opts[:hours]

        # which mpd playlist to load
        @playlist = "eieruhr"
    end

    def sleepit
        system("date") unless @quiet
        puts "Sleeping for " + @seconds.to_s + " seconds" unless @quiet
        sleep @seconds
        system("date") unless @quiet
    end

    def startmusic
        # obviously, if you use alsa and not oss there will be another way,
        # this ossmix command activates my notebook's built-in speakers
        # ossmix jack.int-speaker.mode mix2
        # the alsa alternative: amixer set Speaker unmute
        system("(amixer set Speaker unmute && \
                 mpc clear && \
                 mpc load #{@playlist} && \
                 mpc play) &>/dev/null")
    end

    def notify_me
        case @type
        when "notify-send"
          system(%Q[notify-send -u critical -t 0 Eieruhr "#{Time.new.strftime("%H:%M:%S")}: #{@message} "])
        when "yad"
          system(%Q!yad --title "Eieruhr" --text "#{Time.new.strftime("%H:%M:%S") + ": " + @message} " --button='gtk-ok:0'!)
        else
          puts "Don't have that type of notification"
          exit 1
        end
    end

    def run
        sleepit
        startmusic unless @nosound
        notify_me
    end
end

my = Eieruhr.new(opts)
#if my.instance_variable_get(:@seconds) == 0
#  puts "The total time has to be over 0 seconds"
#  exit 1
#end
my.run
