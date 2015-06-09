require 'pathname'
require_relative 'auto_split'

# This class opens the corresponding test file if the current buffer is
# code and the corresponding code file if the current buffer is a test.
class CorrespondingFileOpenner

  module VIMFile
    def set_buffer(buffer)
      @buffer = buffer
    end

    def file
      @buffer.name
    end

    def extension
      file.split('.').last.upcase
    end
  end

  include VIMFile

  def initialize(vim)
    @commander = vim.commander
    @window = vim.window
    set_buffer @window.buffer
  end

  def open
    get_file
    run_open_command
  end

  def get_file
    @file_path = self.class.const_get("#{extension}Openner").new(file).get
  end

  def run_open_command
    @commander.command(build_command)
  end

  def build_command
    "#{AutoSplit.new(@window).call} #{@file_path}"
  end

  class RBOpenner < Struct.new(:file)
    def get
      if file.match('spec/')
        corresponding_file = Pathname(file.gsub('spec/', 'app/').gsub('_spec.', '.'))
      else
        corresponding_file = Pathname(file.gsub('app/', 'spec/').gsub('.', '_spec.'))
      end
    end
  end

  class JSOpenner < Struct.new(:file)
    def get
      if file.match('spec/')
        corresponding_file = Pathname(file.gsub('spec/', 'public/').gsub('_spec.', '.'))
      else
        corresponding_file = Pathname(file.gsub('public/', 'spec/').gsub('.', '_spec.'))
      end
    end
  end
end
