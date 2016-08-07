module TaskManager
  def to_prompts
    Proc.new {|_,_,_| dump; puts status_line; "> " }
  end

  attr_accessor :tasks, :save_path
  def tasks
    @tasks ||= TaskList.new
  end

  def load_tasks
    if File.exists?(save_path)
      @tasks = Marshal.load(File.read(save_path))
    end
  end

  def dump
    File.open(save_path, "w") {|f| f.puts Marshal.dump(tasks) }
  end

  def status_line
    tasks.first.title
  end

  class TaskList
    def first
      list.first || NullTask
    end

    attr_accessor :list
    def initialize
      self.list = []
    end

    def add(title)
      list << Task.new(title)
    end

    def add!(title)
      list.unshift(Task.new(title))
    end

    def complete(i=0)
      list.delete_at(i)
    end

    def delay(i=1)
      task = self.list.shift
      list.insert(i, task)
    end

    def to_s
      list[1..-1].reverse.map(&:to_s).join("\n")
    end
  end

  class Task < Struct.new(:title)
    alias to_s title
  end

  class NullTask
    class << self
      def title
        "You finished everything! Good job!"
      end
      alias to_s title
    end
  end
end
