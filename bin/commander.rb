#!/usr/bin/ruby
# coding: utf-8
# commander.rb
# Small dialog window that allows persons not familiar
# with this computer to do some emergency tasks like 
# muting the sound or cutting off the network, in cases when 
# i'm not around and the computer is obstructive to others.

class Commander
    def initialize
        @title="Der Commander"
        @text="Wähle eine Aktion aus, oder “Nichts”.\nUm dieses Fenster zu verschieben, WIN-taste gedrückt halten und mit gedrückter Maustaste schieben."
        @action_0="Nichts"
        @action_1="Netzwerk ausschalten"
        @action_2="Ton stummschalten (toggle aus/an)(für wenn Lautsprecher oder irgendwas eingesteckt sind)"
        @action_3="Eingebaute Lautsprecher an/aus"
        @action_4 = "Beende einen rsync download.\nErst diese Option versuchen, um traffic auf null zu bekommen,\nwenn das nicht hilft, dann die 'Netzwerk ausschalten' Option."
        @action_5 = "Zeige Netzwerktraffic"
        @action_6 = "Stelle einen einmaligen Wecker"
    end

    def askuser
        @choice = `yad --width=800 --height=350 --title="#{@title}" --text="#{@text}" --list --separator '' --column "Aktion" "#{@action_0}" "#{@action_5}" "#{@action_1}" "#{@action_2}" "#{@action_3}" "#{@action_4}" "#{@action_6}"`.chomp
    end

    def doit
        askuser
        exit 0 if @choice = ""
        logfile = '/home/ogion/.local/share/commander/log'
        File.open(logfile, 'a') {|f|
            f.puts("#{Time.now}: #{@choice}")
        }
        case @choice
        when @action_0
            exit 0
        when @action_1
            # cut_network.sh is simply netcfg all-suspend and in visudo it's allowed without password
            system("sudo /root/cut_network.sh")
        when @action_2
            system("ossvol -t")
        when @action_3
            system("ruby ~/bin/eee_external_audio_toggle.rb")
        when @action_4
            system("killall rsync")
        when @action_5
            system("urxvtc -e bwm-ng")
        when @action_6
            system("/home/ogion/bin/wecker.rb")
        end
    end
end

command = Commander.new
command.doit
