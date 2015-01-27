args = ARGV.select{|s| s[0] == "-"}
remaining_args = (ARGV - args)
word = remaining_args.shift
path = remaining_args.pop || './'

puts "seeking for '#{word}' with args #{args} under path '#{path}'"

sites_path = '/Users/kstannard/Sites/'
Dir["#{sites_path}{apps,gems}/*"].each do |d|
  finds = %x[~/scripts/bin/project_grep '#{word}' #{args.join(" ")} #{d}/#{path}].gsub(sites_path, '')
  puts finds if finds.strip.size > 0
end
#puts %x[~/scripts/bin/project_grep '#{word}' #{args.join(" ")} #{sites_path}gems/duzica/#{path}].gsub(sites_path, '')
#puts %x[~/scripts/bin/project_grep '#{word}' #{args.join(" ")} #{sites_path}gems/sakura/#{path}].gsub(sites_path, '')
