#! /usr/bin/env ruby-rvm-env 2.1

require File.expand_path('..', __FILE__) + '/utility_classes/lendkey_repos.rb'

Pathname(Dir.home + "/Sites/gems").children.each do |d|
  next if d.file?
  env_name = d.to_s.upcase.gsub('-','_').gsub(/.*\/(.*)/, '\1_DIR')
  puts "export #{env_name}=#{d}"
end
