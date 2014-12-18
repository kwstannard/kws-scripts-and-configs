require 'open3'

class Executor
  class ExecutionError < RuntimeError; end

  def initialize(logger, command, opts = {})
    @logger = logger
    @command = command
    @opts = opts
  end

  def call
    logger.log("COMMAND: #{command}\n#{grepv(opts[:ignore])}")
    Open3.popen2e(command) do |stdin, output, thr|
      @output = ""
      output.each do |line|
        @output += line
        log line
      end
      if thr_error?(thr)
        logger.log_error("COMMAND: #{command}\n#{@output}")
        raise ExecutionError, "Failure: #{command}" if stop_on_error?
      end
    end

    grepv(opts[:ignore])
  end

  # read if there was an error after call was executed
  def error?
    @error
  end

  private

  def stop_on_error?
    @opts.fetch(:stop_on_error, true)
  end

  def thr_error?(thr)
    @error = !(thr.value.exitstatus == 0)
  end

  def log(line)
    logger.log(line)
  end

  def grepv(pattern)
    return @output if pattern.nil?
    @output.each_line.reject{|l| l.match(pattern)}.join
  end

  def logger; @logger; end
  def command; @command; end
  def opts; @opts; end
end
