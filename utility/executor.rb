require 'open3'

class Executor
  def initialize(logger, command, opts = {})
    @logger = logger
    @command = command
    @opts = opts
  end

  def call
    @logger.log("COMMAND: #{command}\n#{grepv(opts[:ignore])}")
    Open3.popen2e(command) do |stdin, output, thr|
      @output = ""
      output.each do |line|
        @output += line
        log line
      end
      if error?(thr)
        logger.log_error("COMMAND: #{command}\n#{@output}") if error?(thr)
        raise "Failure: #{command}" if error?(thr)
      end
    end
    grepv(opts[:ignore])
  end

  def log(line)
    logger.log("COMMAND: #{command}\n#{grepv(opts[:ignore])}")
  end

  def error?(thr)
    !(thr.value.exitstatus == 0)
  end

  def grepv(pattern)
    return @output if pattern.nil?
    @output.each_line.reject{|l| l.match(pattern)}.join
  end

  def logger; @logger; end
  def command; @command; end
  def opts; @opts; end
end
