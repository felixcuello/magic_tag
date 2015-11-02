#!/usr/bin/ruby

require './magic_tag'

unless ARGV[0].nil?
  MagicTag.play(ARGV[0], ARGV[1])
  exit 0
end

puts <<-USAGE

  Welcome To Magick Tag!

  This is a program to tag automatically your MP3 files. The usage is simple.
  This program only takes two parameters:

  MagicTag <directory> [search_pattern]


  ... < to be written :)

USAGE

exit 1

