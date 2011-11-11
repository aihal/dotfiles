#!/usr/bin/ruby
# coding: utf-8
# commander.rb
# Small dialog window that allows persons not familiar
# with this computer to do some emergency tasks like 
# muting the sound or cutting off the network, in cases when 
# i'm not around and the computer is obstructive to others.

# Variables for zenity
title="Der Commander"
text="Wähle eine Aktion aus, oder “Nichts”"
action_0="Nichts"
action_1="Netzwerk ausschalten"
action_2="Ton stummschalten (toggle aus/an)"
action_3="Externes Audio an/aus"

user_choice = `zenity --width=800 --height=400 --title="#{title}" --text="#{text}"  --list --radiolist --column "Auswahl" --column "Aktion" TRUE "#{action_0}" FALSE "#{action_1}" FALSE "#{action_2}" FALSE "#{action_3}"`.chomp


case user_choice
when action_0
    exit 0
when action_1
    # cut_network.sh is simply netcfg all-suspend and in visudo it's allowed without password
    system("sudo /root/cut_network.sh")
when action_2
    system("ossvol -t")
when action_3
    system("ruby ~/bin/eee_external_audio_toggle.rb")
end
