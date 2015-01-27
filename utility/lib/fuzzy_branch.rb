class FuzzyBranch < Struct.new(:search_term, :interactive)
  def self.call(search_term, interactive = false)
    new(search_term, interactive).call
  end

  def call
    dev_branch || local_branch || remote_branch || search_term
  end

  private

  def dev_branch
    if search_term == 'dev'
      local_branches.detect{|b| b == 'dev'} || 'master'
    else
      false
    end
  end

  def local_branch
    if local_branches.size == 1
      local_branches.first
    elsif local_branches.empty?
      false
    else
      local_branches.detect{|b| b =~ /^\w\w-#{search_term}_/} ||
      false
    end
  end

  def remote_branch
    if remote_branches.size == 0
      false
    elsif remote_branches.size == 1
      remote_branches.first.gsub(/.*\//, '')
    else
      interactive ? false : ask_user
    end
  end

  def ask_user
    remote_branches.each_with_index do |name, index|
      puts "#{index}: #{name}"
    end
    index = $stdin.gets
    remote_branches.fetch(index.to_i, false)
  end

  def local_branches
    @l_branches ||= `git branch --list *#{search_term}*`.sub(/^\*/,"").split.map(&:strip)
  end

  def remote_branches
    @r_branches ||= `git branch -r --list *#{search_term}*`.gsub(/^.*\//, '').split.map(&:strip)
  end
end
