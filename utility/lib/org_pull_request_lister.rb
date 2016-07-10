require_relative 'closed_struct'
require 'pry'
require 'pathname'
require 'yaml'
require 'octokit'

class OrgPullRequestLister < Struct.new(:read_io, :write_io)
  def self.call(read_io, write_io)
    new(read_io, write_io).call
  end

  def call
    get_org_from_user
    get_repo_filter_from_user
    open_involved_pull_requests
    list_open_pull_requests
  end

  private

  def open_involved_pull_requests
    open_new_firefox_window
    `open #{involved_pull_requests.map(&:html_url).join(" ")}` if involved_pull_requests.count > 1
  end

  def list_open_pull_requests
    filtered_pull_requests.sort_by{|o| o.comments}.each do |p|
      puts "#{p.comments} || #{p.title}"
      puts p.html_url
      puts
    end
  end

  def open_new_firefox_window
    #implement this
  end

  def filtered_pull_requests
    all_pull_requests.send(@repo_filter_method) do |i|
      i.url.match(/\/(#{@repo_filter.join("|")})\//)
    end
  end

  def involved_pull_requests
    @ipr ||= github.search_issues("type:pr state:open user:#{@org} involves:#{permissions[:login]}").items
  end

  def all_pull_requests
    github.search_issues("type:pr state:open user:#{@org}", per_page: 100).items
  end

  def get_org_from_user
    write_io.print 'org name: '
    @org = read_io.gets.strip
    write_io.puts "getting repos for #{@org}"
  end

  def get_repo_filter_from_user
    write_io.print 'list repo names: '
    @repo_filter = read_io.gets.strip.split(" ")
    write_io.print 'filter type (+,-): '
    case read_io.gets.strip
    when '+' then @repo_filter_method = :select
    when '-' then @repo_filter_method = :reject
    else raise 'not valid filter'
    end
  end

  def github
    @github ||= Octokit::Client.new(permissions)
  end

  def permissions
    file = Pathname(Dir.home).join('.config/hub')
    file_info = YAML.load_file(file).fetch('github.com').fetch(0)
    {login: file_info.fetch('user'), password: file_info.fetch('oauth_token')}
  end
end
