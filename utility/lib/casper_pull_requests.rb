require_relative "org_pull_request_lister"
class CasperPullRequests
  def self.call
    new.call
    self
  end

  def call
    OrgPullRequestLister.call(cs_io, cs_io)
  end

  def cs_io
    @cs_io ||= CasperSleepIO.new
  end

  class CasperSleepIO
    def initialize
      @queue = []
    end

    def gets
      @queue.shift
    end

    def puts(text)
      case text
      when /org name:/i
        @queue.push("CasperSleep")
      when /list repo names:/i
        @queue.push(Pathname.glob(Dir.home+"/work/*").map(&:basename).join(" "))
      when /filter type/i
        @queue.push("+")
      end
    end
    alias print puts
  end
end
