#!/usr/bin/ruby
# coding: utf-8
# wecker.rb
# requires yad, crontab, mpd/c, alsa, notify-send. The actual command that does
# the alarm can be easily changed, relies on amixer/alsa (in this case to
# activate my netbooks built-in speakers), mpc to play music with mpd, and
# notify-send to send a message to the user
#

class Wecker
  def initialize
  end

  def buildcronentry
    # putting together a crontab entry, that looks like so:
    # minute hour day month weekday command

    # @chosen_hour should come from yad as ??:?? where ? is a digit
    hour,minute = @chosen_hour.split(":")
    # @chosen_day should come from yad as dd.mm where where dd is the decimal
    # 0-padded day and mm is the 0-padded decimal month
    day,month = @chosen_day.split(".")

    # we don't care about what day of the week it is
    weekday = "*"
    command = %Q|(amixer set Speaker unmute && amixer set Master -q 70 && mpc play; DISPLAY=":0" notify-send -u critical "weckeradd" "#{@notification_text}")|

    return [minute,hour,day,month,weekday,command].join(" ")
  end

  def showcronentry
    # for debugging
    puts buildcronentry
  end

  def savecronentry
    # get the current crontab
    crontab = `crontab -l`

    # add our new entry, with newline at the end, otherwise crontab won't accept it
    crontab += "\n#{buildcronentry} #weckeradd\n"

    # give the crontab command the new data on stdin
    IO.popen("crontab -", mode="w") do |x|
      x.write crontab
    end
  end

  def askUser
    # have to add the --date-format option, dunno why it suddenly changed. might be yad or might be some 
    # locale thing on my machine %d ist day of month in decimal, %m is month in decimal
    @chosen_day = `yad --date-format="%d.%m" --calendar --text="Wähle den Tag aus für den einmaligen Weckvorgang (der heutige Tag ist automatisch ausgewählt)" --title="Einmaliger Wecker"`.chomp
    exit 0 if @chosen_day == ""


    # ask for the hour:minute
    @chosen_hour = `yad --entry --text="Gib die Weckuhrzeit an, in HH:MM (Stunde:Minute) Format:" --title="Weckuhrzeit"`.chomp

    # ensure we either get an ESC or a properly formatted time string
    while true
      break if @chosen_hour =~ /\A\d\d:\d\d\Z/
      exit 0 if @chosen_hour == ""
      @chosen_hour = `yad --entry --text="Das Format war nicht richtig, bitte nochmal eingeben! Gebe die Weckuhrzeit an, in HH:MM (Stunde:Minute) Format:" --title="Weckuhrzeit"`.chomp
    end

    # ask for a text for the notification
    @notification_text = `yad --entry --entry-text="Weckzeit abgelaufen" --text="Bitte einen Text für die Benachrichtigung eingeben" --title="Textbenachrichtigung"`.chomp
  end

end

mywecker = Wecker.new
mywecker.askUser
mywecker.savecronentry
