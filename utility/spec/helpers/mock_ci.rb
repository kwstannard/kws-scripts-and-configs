class CIProjectsInfo
  def initialize(*projects)
    @projects = projects.map{|p| CIProject.new(p)}
  end

  def projects
    @projects
  end

  class CIProject
    attr_reader :project
    def initialize(project)
      @project = project
      get_branches
    end

    def name
      project.repository.name
    end

    def git
      project.git
    end
    def get_branches
      @branches ||= git.branches.local.map{|b| CIBranch.new(b.name, get_builds(b))}
    end

    def get_builds(branch)
      commits = git.gblob(branch.name).log(5)

      commits.map{|c| CIBuild.new(c, 'failed') }
    end

    def get_branch(name)
      get_branches.detect{|b| b.name == name}
    end
  end

  class CIBranch
    attr_accessor :name, :builds
    def initialize(name, builds)
      @name = name
      @builds = builds
    end

    alias get_builds builds

    def set_last_good_build(sha)
      @builds.detect{|b| b.commit.id == sha}.result = 'passed'
    end
  end

  class CIBuild
    attr_accessor :commit, :result
    def initialize(commit, result)
      @commit = CICommit.new(commit)
      @result = result
    end
  end

  class CICommit
    def initialize(commit)
      @commit = commit
    end

    def id
      @commit.sha
    end
  end
end

