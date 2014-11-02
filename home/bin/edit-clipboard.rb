#!/usr/bin/ruby
# edit-clipboard.rb

exit 1 unless ARGV[0]
if ARGV[0] != "link" and ARGV[0] != "text"
  puts "only link and text are valid arguments."
  exit 1
end

case ARGV[0]
when "link"
  system(%Q!echo '#{`xclip -o`.split.join}' | xclip -i!)
when "text"
  system(%Q!echo '#{`xclip -o`.split.join(" ")}' | xclip -i!)
end
