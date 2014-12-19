class TestDirHelper
  attr_reader :path
  def initialize(dir)
    @path = "/tmp/test_dir_helper_#{dir}"
  end

  def setup
    @here = Dir.pwd
    @there = Pathname.new(path)

    @there.mkdir
    Dir.chdir @there

    self
  end

  def add_project(name)
    Project.new(@there.join(name))
  end

  class Project
    attr_reader :path, :git
    def initialize(path)
      @path = path
      path.mkdir
      Dir.chdir path

      @git = Git.init(Dir.pwd)
      readme = Pathname.new("#{Dir.pwd}/readme.md")
      readme.open('w') {|f| f.write 'hi'}
      @git.add readme.to_s
      @git.commit_all("first_commit")

      @git.branch('dev').checkout
    end

    def repository
      Repository.new(path, [])
    end

    def name
      repository.name
    end

    def write_file name, file_path="", text="HI"
      path.join(file_path).join(name).open('w') {|f| f.write(text) }
    end

    def make_commits(n)
      n.times { make_commit('random commit') }
    end

    def merge_tickets(*tickets)
      tickets.each {|ticket| make_commit("Merge pull request #xxx from user/#{ticket}") }
    end

    def make_commit(message)
      readme = Pathname.new("#{Dir.pwd}/readme.md")
      readme.open('r+') {|f| f.write f.read+'hi'}

      @git.add readme.to_s
      @git.commit_all(message)
    end
  end

  def teardown
    @there.rmtree
    Dir.chdir @here
  end
end
