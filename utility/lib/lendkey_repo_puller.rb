require_relative "org_repo_puller"
class LendkeyRepoPuller
  def self.call
    new.call
  end

  def call
    setup_dir_structure
    OrgRepoPuller.call(lk_io, lk_io)
    move_repos
    delete_tmp_directory
  end

  def setup_dir_structure
    tmpdir.dirname.mkdir unless tmpdir.dirname.exist?
    tmpdir.mkdir unless tmpdir.exist?
  end

  def move_repos
  end

  def delete_tmp_repos
    puts tmpdir.children.inspect
    tmpdir.rmdir
  end

  def tmpdir
    @tmpdir ||= Pathname("~/Sites/tmpdir").expand_path
  end

  def lk_io
    @lk_io ||= LendkeyIO.new
  end

  class LendkeyIO
    def initialize
      @queue = []
    end

    def gets
      $stdout.puts @queue
      @queue.shift
    end

    def puts(text)
      case text
      when /org name:/i
        @queue.push("lendkey")
      when /path to base org dir/i
        @queue.push("~/Sites")
      when /would you like.*clone/i
        @queue.push("y")
      when /what subdirectory/i
        @queue.push("tmpdir")
      end
      $stdout.puts @queue.inspect
    end
    alias print puts
  end
end
