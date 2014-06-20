class FindAndReplaceText < Struct.new(:find_pattern, :replace_pattern)
  def call
    files.each do |file|
      gsub_file(file) if changable?(file)
    end
  end

  private

  def files
    Dir["#{Dir.pwd}/**/*"]
  end

  def gsub_file(file)
    text = File.read(file)
    File.open(file, 'w+') do |f|
      f.write text.gsub(/#{find_pattern}/, replace_pattern)
    end
  end

  def changable?(file)
    file.match(/\.(rb|yml|erb|haml|feature)/)
  end
end
