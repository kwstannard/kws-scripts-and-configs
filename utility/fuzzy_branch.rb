class FuzzyBranch < Struct.new(:search_term)
  def self.call(search_term)
    new(search_term).call
  end

  def call
    local_branch || remote_branch || search_term
  end

  private

  def local_branch
    if local_branches.size == 1
      local_branches.first#.gsub(/.*\//, '')
    else
      false
    end
  end

  def remote_branch
    if remote_branches.size == 0
      false
    elsif remote_branches.size == 1
      remote_branches.first.gsub(/.*\//, '')
    else
      remote_branches.each_with_index do |name, index|
        puts "#{index}: #{name}"
      end
      index = $stdin.gets
      remote_branches.fetch(index.to_i, false)
    end
  end

  def local_branches
    @l_branches ||= `git branch --list *#{search_term}*`.split
  end

  def remote_branches
    @r_branches ||= `git branch -r --list *#{search_term}*`.split
  end
end
