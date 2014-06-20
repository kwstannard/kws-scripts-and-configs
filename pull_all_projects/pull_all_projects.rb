#! /usr/bin/ruby
require 'pathname'
require 'open3'

class AllProjectPuller
  def call
    root_dir = "#{Dir.home}/Sites"
    directories = Pathname.glob("#{root_dir}/apps/*") +
      %w[elasys_exporter
        elasys_btable
        experian
        ecsi
        baycities
        certifier
        reliamax
        paperclip_strongbox
        sakura
        service_connections
        duzica
    ].map{|a| Pathname.new("#{root_dir}/gems/#{a}")}

    directories.each do |d|
      Dir.chdir(d) do
        ProjectPuller.new.call
      end
    end
  end
end

class ProjectPuller
  def call
    clear_logs
    print "#{dir.ljust(50, '_')} => "
    from_branch 'dev' do
      ex 'git pull'
      install_gems
      Dir.chdir(migration_dir) do
        migrate
      end
    end
    puts (@executions.any?(&:error?) ? "Fail" : "Pass")
  rescue => e
    puts "Fail"
    log_error(e.message)
  end

  def install_gems
    if File.exist?("Gemfile")
      ex "rvm #{gemset} do bundle install"
    end
  end

  def migrate
    if ['../../db/schema.rb', 'db/schema.rb'].any?{|f| Dir.exist?(f)}
      ex "rvm #{gemset} do rake db:migrate db:test:prepare", ignore: "sec:"
    end
  end

  def gemset
    return @gemset if @gemset
    rvm_ruby_version = File.read(".ruby-version").gsub("/n", '')
    rvm_gemset = File.read(".ruby-gemset").gsub("/n", '')
    @gemset = "#{rvm_ruby_version}@#{rvm_gemset}"
  end

  def migration_dir
    Dir.exist?('spec/dummy') ? 'spec/dummy' : '.'
  end

  def from_branch(branch, &block)
    original_branch = g_branchname
    stash_changes
    clear_branch
    ex "git co #{branch}" unless branch == original_branch
    yield
    clear_branch
    ex "git co #{original_branch}" unless branch == original_branch
    unstash
  end

  def g_branchname
    %x{git rev-parse --abbrev-ref HEAD 2>/dev/null}.gsub(/\n/, '')
  end

  def stash_changes
    if !git_changes.empty?
      ex 'git stash clear; git stash'
    end
  end

  def unstash
    if !git_changes.empty?
      ex 'git stash pop'
    end
  end

  def git_changes
    @git_changes ||= ex "git st -s | tr -d ' '"
  end

  def clear_branch
    ex 'git reset --hard'
    ex 'git co .'
  end

  def dir
    @dir ||= Dir.pwd
  end

  def ex(*args)
    execution = Execution.new(self, *args)
    executions << execution
    execution.call
  end

  def executions
    @executions ||= Array.new
  end

  def log(text)
    File.open(log_path, 'a') do |f|
      f.write "#{text}\n\n"
    end
  end

  def log_error(text)
    File.open(error_log_path, 'a') do |f|
      f.write "#{text}\n\n"
    end
  end

  def clear_logs
    ex 'mkdir -p ~/Sites/pap/'
    File.delete(log_path) if File.exist?(log_path)
    File.delete(error_log_path) if File.exist?(error_log_path)
  end

  def log_path
    root_dir = "#{Dir.home}/Sites/pap"
    "#{root_dir}/#{self}.log"
  end

  def error_log_path
    root_dir = "#{Dir.home}/Sites/pap"
    "#{root_dir}/#{self}_error.log"
  end

  def to_s
    dir.gsub(/.*\/(.*)/, '\1')
  end

  class Execution
    def initialize(executor, command, opts = {})
      @executor = executor
      @command = command
      @opts = opts
    end

    def call
      @output, @error, @status = Open3.capture3(command)
      log
      raise "Failure: #{self}" if error?
      grepv(opts[:ignore])
    end

    def log
      executor.log_error("COMMAND: #{command}\n#{@error}") if error?
      executor.log("COMMAND: #{command}\n#{grepv(opts[:ignore])}")
    end

    def error?
      !@error.empty?
    end

    def grepv(pattern)
      return @output if pattern.nil?
      @output.each_line.reject{|l| l.match(pattern)}.join
    end

    def executor; @executor; end
    def command; @command; end
    def opts; @opts; end
  end
end

AllProjectPuller.new.call
