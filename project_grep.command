#! /usr/bin/env ruby

options = []
word = nil
place = ./

ARGV.each do |a|
  case
  when a.match(/\A-/)
    options << a
  when word
    place = a
  else
    word = a
  end
end

puts word
puts options
puts place

