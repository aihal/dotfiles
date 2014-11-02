#!/usr/bin/ruby
# coding: utf-8
# wecker.rb
# requires yad, crontab, mpc, oss. The actual command that does the 
# alarm can be easily changed, relies on oss (in this case to activate my netbooks
# built-in speakers, and mpc to start a particular playlist.
#

class Wecker
  def initialize
  end

  def buildcronentry
    # putting together a crontab entry:
    # that looks like so: minute hour day month weekday command
    hour,minute = @chosen_hour.split(":")
    day = @chosen_day.split(".")[0]
    month = @chosen_day.split(".")[1]
    weekday = "*"
    command = "(ossmix jack.int-speaker.mode mix2 && mpc clear && mpc load ogi && mpc play)"

    return [minute,hour,day,month,weekday,command].join(" ")
  end

  def showcronentry
    puts buildcronentry
  end

  def savecronentry
    # would do this with File.open(file, 'a') do...
    # except crontab is picky and doesn't  want us to 
    # modify any file directly, only through 'crontab'
    system("/usr/bin/crontab -l | sed -e '$a #{buildcronentry} #weckeradd' | /usr/bin/crontab -")
  end

  def askforDateandTime
    @chosen_day = `yad --calendar --text="Wähle den Tag aus für den einmaligen Weckvorgang (der heutige Tag ist automatisch ausgewählt)" --title="Einmaliger Wecker"`.chomp
    exit 0 if @chosen_day == ""
    @chosen_hour = `yad --entry --text="Gib die Weckuhrzeit an, in HH:MM (Stunde:Minute) Format:" --title="Weckuhrzeit"`.chomp
    while true
      break if @chosen_hour =~ /\A\d\d:\d\d\Z/
      exit 0 if @chosen_hour == ""
      @chosen_hour = `yad --entry --text="Das Format war nicht richtig, bitte nochmal eingeben! Gebe die Weckuhrzeit an, in HH:MM (Stunde:Minute) Format:" --title="Weckuhrzeit"`.chomp
    end
  end
end

mywecker = Wecker.new
mywecker.askforDateandTime
mywecker.savecronentry
