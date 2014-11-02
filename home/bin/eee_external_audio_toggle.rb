#!/usr/bin/ruby
# speaker
state = `amixer set Speaker toggle`.split.last
system("notify-send -t 3000 'toggle speakers' 'Eingebaute Lautsprecher sind jetzt #{state}'")
