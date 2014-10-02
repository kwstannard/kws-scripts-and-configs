require "#{Dir.pwd}/utility/lendkey"

aliases = YAML.load_file '/Users/kstannard/aliases.yml' rescue
aliases ||= {}
counts = Hash.new {|h, k| h[k] = {commits: 0, files: 0, insertions: 0, deletions: 0} }

Lendkey.repo_paths.each do |path|
  puts path
  Dir.chdir(path) do
    `git log --shortstat --no-merges --since=07/16/2013 --pretty=format:"%an" -- {app,lib}`.split("\n\n").each do |line|

      committer = line.match(/[^\n]*/)[0]
      files = (line.match(/(\d+) file/) || [])[1].to_i
      insertions = (line.match(/(\d+) insert/) || [])[1].to_i
      deletions = (line.match(/(\d+) delet/) || [])[1].to_i

      if !aliases[committer]
        puts "alias for #{committer} >> "
        _alias = gets.strip
        aliases[committer] = _alias
      end

      counts[aliases[committer]][:commits] += 1
      counts[aliases[committer]][:files] += files
      counts[aliases[committer]][:insertions] += insertions
      counts[aliases[committer]][:deletions] += deletions
    end
  end
end

File.open('/Users/kstannard/aliases.yml', 'w') {|f| YAML.dump(aliases, f)}
File.open('/Users/kstannard/code_commit_counts.yml', 'w') {|f| YAML.dump(counts, f)}
