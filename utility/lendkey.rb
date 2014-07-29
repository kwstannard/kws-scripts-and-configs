require File.expand_path('..', __FILE__) + '/executor'
require 'pathname'

class Lendkey
  def self.method_missing(method, *args, &block)
    new.send(method, *args, &block)
  end

  def remote_repos
#    repos ||= Executor.new.call('hub repos lendkey').map(&:name)
  end

  def repos
    end_names_of(repo_paths)
  end

  def repo_paths
    app_paths + gem_paths
  end

  def app_paths
    repos_under_dir 'apps'
  end

  def services
  end

  def greenhouse
  end

  def gem_paths
    repos_under_dir 'gems'
  end

  def repos_under_dir(dir)
    Pathname.glob(lendkey_path + "/#{dir}/*")
  end

  def end_names_of(dirs)
    dirs.map{|p| p.basename.to_s.gsub(/.*\/(\w+)$/, '\1')}
  end

  def lendkey_path
    "#{ENV['LENDKEY_PATH'] || Dir.home + '/Sites'}"
  end
end
