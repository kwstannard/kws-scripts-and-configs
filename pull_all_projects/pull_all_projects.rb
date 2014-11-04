#! /usr/bin/env rvm 2.1.1@default do ruby

require 'pathname'

require_relative '../utility/executor'
require_relative '../utility/ruby_version'

class AllProjectPuller
  def call
    root_dir = "#{Dir.home}/Sites"
    directories = Pathname.glob("#{root_dir}/apps/*") +
      Pathname.glob("#{root_dir}/gems/*") +
      Pathname.glob("#{root_dir}/configs") +
      Pathname.glob("#{root_dir}/utilities/*") +
      Pathname.glob("#{root_dir}/scripts/release")

    directories.each do |d|
      fork do
        Dir.chdir(d) do
          ProjectPuller.new.call
        end
      end
    end

    Process.waitall
  end
end

class ProjectPuller
  def call
    clear_logs
    output_string = "#{dir.ljust(50, '_')} => "
    from_branch development_branch do
      if (!ex('git pull').match("is up to date"))
        install_gems
        Dir.chdir(migration_dir) do
          migrate
        end
      end
    end
    output_string += (@executions.any?(&:error?) ? "Fail" : "Pass")
  rescue => e
    output_string += "Fail"
    log_error_with_backtrace(e.message, e.backtrace)
  ensure
    puts output_string
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
    @gemset = RubyVersion.current
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

  def development_branch
    return @development_branch if @development_branch
    branches = ex "git branch --list" 
    @development_branch = %w[dev  master].detect{|b| branches.include?(b)}
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
    @git_changes ||= ex "git st --porcelain --untracked-files=no | tr -d ' '"
  end

  def clear_branch
    ex 'git reset --hard'
    ex 'git co .'
  end

  def dir
    @dir ||= Dir.pwd
  end

  def ex(*args)
    execution = Executor.new(self, *args)
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
      f.write "#{text}"
    end
  end

  def log_error_with_backtrace(message, trace)
    File.open(error_log_path, 'a') do |f|
      f.write "#{message}"
      f.write "#{trace}"
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

end

AllProjectPuller.new.call
