#! /usr/bin/env ruby-rvm-env 2.1

require File.expand_path('..', __FILE__) + '/utility_classes/lendkey_repos.rb'

GemFinder.in_dir(Dir.home + "/Sites/gems").each do |gem|
  env_name = gem.name.upcase.gsub('-','_')
  puts "unset #{env_name}"
end
#Pathname(Dir.home + "/Sites/gems").children.each do |d|
#  next if d.file?
#  env_name = d.to_s.upcase.gsub('-','_').gsub(/.*\/(.*)/, '\1_DIR')
#  puts "unset #{env_name}"
#end
