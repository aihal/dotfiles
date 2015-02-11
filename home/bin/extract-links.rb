#!/usr/bin/ruby
# coding: utf-8
# extract-links.rb

require 'nokogiri'
require 'open-uri'

links = []

ARGV.each do |target|

  while true
    begin
      page = open(target) {|x| x.read}
    rescue OpenURI::HTTPError
      #handle a sort of 404 differently from others?
      #if mistakenly given a link that works but has 
      #no actual video links. possibly have to handle
      #this further down during parsing
      STDERR.puts "httperror » retrying " + target
      redo
    else
      break
    end
  end

  doc = Nokogiri::HTML.parse(page)

  l = doc.css("a").map {|link| link}
  l.select! {|x| x.attr("title") == "video.tt"}


  while true
    begin# .attr breaks here if there are no video.tt links on the page, could catch that above
      page2 = open("http://watchseries.ag#{l.first.attr('href')}") {|x| x.read} 
    rescue OpenURI::HTTPError
      STDERR.puts "httperror » retrying"
      redo
    else
      break
    end
  end
  doc2 = Nokogiri::HTML.parse(page2)
  l2 = doc2.css("a").map {|link| link}
  l2.select! {|x| x.attr("class") == "myButton"}
  links << l2.first.attr("href")

end#ARGV.each

puts links