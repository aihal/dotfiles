#!/usr/bin/ruby
# coding: utf-8
# ext_ip_logger.rb

#alternative http://whatismyip.org/

require 'open-uri'

def logit(ip)
  open("/home/ogion/tom/external_ip_logfile", 'a') do |f|
    if ip == "error"
      f.write("#{Time.now} Ein Fehler ist aufgetreten bei der Ermittlung der externen IP\n")
    else
      f.write("#{Time.now} Externe IP ist: #{ip}\n")
    end
  end
end

begin
  s = open("http://jsonip.com")
rescue 
  logit("error")
else
  logit(s.string)
end

