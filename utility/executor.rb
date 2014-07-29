require 'open3'

class Executor
  def initialize(executor, command, opts = {})
    @executor = executor
    @command = command
    @opts = opts
  end

  def call
    @output, @status = Open3.capture2e(command)
    log
    raise "Failure: #{self}" if error?
    grepv(opts[:ignore])
  end

  def log
    executor.log_error("COMMAND: #{command}\n#{@output}") if error?
    executor.log("COMMAND: #{command}\n#{grepv(opts[:ignore])}")
  end

  def error?
    !(@status == 0)
  end

  def grepv(pattern)
    return @output if pattern.nil?
    @output.each_line.reject{|l| l.match(pattern)}.join
  end

  def executor; @executor; end
  def command; @command; end
  def opts; @opts; end
end
