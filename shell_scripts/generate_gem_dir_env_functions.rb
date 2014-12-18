#! /usr/bin/env ruby

require 'pathname'
require 'delegate'
require File.expand_path('../../utility/gem_finder.rb', __FILE__)

class GemDirEnvFunctionGenerator
  def call
    puts unset_all_gems_function
    puts export_all_gems_function
    gems.each do |gem|
      puts unset_function(gem)
      puts export_function(gem)
    end
  end

  private

  def gems
    @gems ||= unmemoized_gems
  end

  def unmemoized_gems
    path = Pathname(Dir.home + "/Sites/gems")
    GemDecorator.build_from_array(GemFinder.in_dir(path))
  end

  def unset_all_gems_function
    function = "unset_all_gem_dirs(){\n"
    gems.each do |gem|
      function += "  unset #{gem.env_name};\n"
    end
    function + "};\n"
  end

  def export_all_gems_function
    function = "set_all_gem_dirs(){\n"
    gems.each do |gem|
      function += "  export #{gem.env_name}=#{gem.path};\n"
    end
    function + "};\n"
  end

  def unset_function(gem)
    "unset_#{gem.name}(){ unset #{gem.env_name}; };\n"
  end

  def export_function(gem)
    "set_#{gem.name}(){ export #{gem.env_name}=#{gem.path}; };\n"
  end

  class GemDecorator < SimpleDelegator
    def env_name
      @env_name ||= "#{name.upcase.gsub('-','_')}_DIR"
    end

    def self.build_from_array(array)
      array.map{|g| new(g)}
    end
  end
end

GemDirEnvFunctionGenerator.new.call
