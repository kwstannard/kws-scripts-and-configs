class RubyVersion
  def self.current
    factory.current
  end

  def self.factory
    if version_file_exists?
      Files.new
    elsif rvm_present?
      RVM.new
    elsif rbenv_present?
      RbEnv.new
    else
      raise "no ruby versioning present"
    end
  end

  def current
    @current ||= "#{version}@#{gemset}"
  end

  private

  def self.rvm_present?
    !%{ which rvm }.empty?
  end

  def self.rbenv_present?
    !%{ which rbenv }.empty?
  end

  def self.version_file_exists?
    File.exist?(".ruby-version")
  end

  class RVM < RubyVersion
    def current
      @current ||= `rvm current`.strip
    end

    def version
      current.split('@').first
    end

    def gemset
      current.split('@').last
    end
  end

  class RbEnv < RubyVersion
    def version
      @version ||= `rbenv version`.strip
    end

    def gemset
      @gemset ||= `rbenv gemset active`.split.first
    end
  end

  class Files < RubyVersion
    def version
      @ruby_version ||= File.read(".ruby-version").strip
    end

    def gemset
      @gemset ||= if gemset_file_exists?
        File.read(".ruby-gemset").strip
      else
        "default"
      end
    end

    def gemset_file_exists?
      @gemset_file_exists ||= File.exist?(".ruby-gemset")
    end
  end
end
