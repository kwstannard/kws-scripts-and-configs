require_relative 'closed_struct'
require 'yaml'
require 'octokit'

class OrgRepoPuller < Struct.new(:read_io, :write_io)
  def self.call(read_io, write_io)
    new(read_io, write_io).call
  end

  def call
    get_org_from_user
    get_org_repo_info
    clone_org_repos
  end

  private

  def get_org_from_user
    write_io.print 'org name: '
    @org = read_io.gets.strip
    write_io.puts "getting repos for #{@org}"
  end

  def get_org_repo_info
    @repos = github.organization_repositories(@org, per_page: 100).map{|r|
      ClosedStruct.new(r)
    }
  end

  def clone_org_repos
    write_io.print "path to base org dir (eg. `~/Sites`): "
    base_dir = Pathname(read_io.gets.strip).expand_path
    @repos.each do |repo|
      next if already_cloned?(base_dir, repo) || user_doesnt_want_to_clone?(repo)
      write_io.print "what subdirectory would you like to clone to (eg. `gems` or leave blank): "
      dir = read_io.gets.strip
      `git clone #{repo.ssh_url} #{base_dir}/#{dir}/#{repo.name}`
    end
  end

  def user_doesnt_want_to_clone?(repo)
    write_io.puts "### now cloning #{repo.name}"
    write_io.print "Would you like to clone this repo? (Y/n)"
    !read_io.gets.match(/^(y|yes|sure|why not|punch it|)$/i)
  end

  def already_cloned?(base_dir, repo)
    !Pathname.glob(base_dir + "**/#{repo.name}/.git").empty?
  end

  def github
    @github ||= Octokit::Client.new(permissions)
  end

  def permissions
    file = Pathname(Dir.home) + '.config/github_cmd_line_auth'
    file_info = YAML.load_file(file).fetch('github.com').fetch(0)
    {login: file_info.fetch('user'), password: file_info.fetch('oauth_token')}
  end
end
