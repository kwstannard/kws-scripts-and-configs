require "#{Dir.pwd}/utility/lendkey"

counts = {specs: 0, methods: 0, conditionals: 0}

Lendkey.repo_paths.each do |path|
  puts path
  Dir.chdir(path) do
    counts[:conditionals] += `grep '\\(if\\|when\\|unless\\)' -wrn ./{app,lib} | wc -l`.to_i
    counts[:methods] += `grep '\\(def\\|define_method\\)' -wrn ./{app,lib} | wc -l`.to_i
    counts[:specs] += `grep '\\(it\\|Scenario\\)' -wrn ./{spec,feature} | wc -l`.to_i
  end
end

File.open('/Users/kstannard/specs_vs_defs.yml', 'w') {|f| YAML.dump(counts, f)}
