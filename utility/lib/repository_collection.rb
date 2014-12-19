require_relative 'return_same'

class RepositoryCollection
  include Enumerable
  extend ReturnSame
  return_same :map, :select, :reject

  def self.from_dir(directory)
    repos = Array.new

    Pathname.glob(directory + "/**/.git").each do |git_path|
      path = git_path.parent
      repos.push Repository.new(path, self)
    end

    new(repos)
  end

  def initialize(repos)
    @repos = repos
  end

  ### scopes

  def gems
    @gems ||= repos.select{|r| r.path.children.detect{|f| f.to_s.match(/gemspec/)}}
  end
  return_same :gems

  def deployable
    @deployable ||= repos.select {|r| r.deployable?}
  end
  return_same :deployable
  alias apps deployable

  def marketplace
    repos.select{|r| r.groups.include?('marketplace')}
  end
  return_same :marketplace

  def greenhouse
    repos.select{|r| r.groups.include?('greenhouse')}
  end
  return_same :greenhouse

  ### queries

  def [](int)
    @repos[int]
  end

  def each &block
    @repos.each {|r| yield r }
  end

  private

  def repos
    @repos
  end

end
