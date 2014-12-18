class GemFinder
  def self.in_dir(path)
    Pathname.glob(path + "**/*.gemspec").reduce(Array.new) do |gems, file|
      gems << Gem.new(file)
      gems
    end
  end

  class Gem
    attr_reader :path, :name, :gemspec

    def initialize(file)
      @gemspec = file
      @path = file.parent
      @name = file.to_s.scan(/[^\/]+(?=\.gemspec$)/).first
    end
  end
end
