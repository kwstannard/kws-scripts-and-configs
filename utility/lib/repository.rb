require 'git'
require File.expand_path("../repository", __FILE__)

class Release
end

class NoRelease < Release
  def tickets
    repo.tickets_between('master', 'dev')
  end

  def tickets_not_included
    []
  end
end

class Repository < Struct.new(:path, :repos)
  def name
    path.basename.to_s
  end

  def groups
    repo_info.fetch("groups", "unknown")
  end

  def local_dependencies
    @l_depancies ||= read('Gemfile').scan(/^\s*custom_require ['"](\w+)['"]/).flatten.map do |name|
      repos.detect{ |r| r.name == name }
    end.compact
  end

  def dependencies
  end

  def local_dependents
    @l_dependants ||= repos.select do |repo|
      repo.local_dependencies.include? self
    end
  end

  def deployable?
    has_file?('Capfile')
  end

  def needs_release?
  end

  class Branch < Struct.new(:branch)
    def release?
      name.include? 'rel-'
    end
  end

  def last_release_branch
    git.branches.remote.map{|b| Branch.new(b) }.select(&:is_release?).sort.fetch(-1).gsub('origin/', '')
  end

  def last_commit branch
    git.gblob(branch).log.first
  end

  def tickets_between first_exclusive, last_inclusive
    commits_between(first_exclusive, last_inclusive).
      grep('Merge').
      map{|c| c.message.slice(/FY-\d+/)}.
      compact
  end

  def to_s
    '%s name=%s, path: %s' % [self.class, name.inspect, path]
  end

  def <=>(repo)
    self.name <=> repo.name
  end

  def git
    @git ||= Git.open(path)
  end

  private

  def release_name_separator
    if deployable?
      "-"
    else
      "."
    end
  end

  def has_file?(file)
    path.join(file).exist?
  end

  def commits_between first_exclusive, last_inclusive
    git.log.between(first_exclusive, last_inclusive)
  end

  def read(file)
    if has_file?(file)
      path.join(file).read
    else
      ""
    end
  end

  def repo_info
    return @repo_info if @repo_info
    if has_file?("repo_info.yml")
      @repo_info = YAML.load(path.join("repo_info.yml").read)
    else
      @repo_info = Hash.new
    end
  end
end
