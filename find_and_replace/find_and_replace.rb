class FindAndReplacePath < Struct.new(:find_pattern, :replace_pattern)
  def call
    puts "#{find_pattern.inspect} => #{replace_pattern.inspect}"

    files.each do |file|
      %x(mv #{file} #{file.gsub(find_pattern, replace_pattern)})
    end
  end

  private

  def files
    Dir["#{Dir.pwd}/**/*"].select{|f| File.file?(f)}
  end
end

class FindAndReplaceText < Struct.new(:find_pattern, :replace_pattern, :file_pattern)
  def call
    puts "#{find_pattern.inspect} => #{replace_pattern.inspect}"
    files.each do |file|
      gsub_file(file)
    end
  end

  def file_pattern
    super || '{Rakefile,*.{rb,yml,erb,haml,feature,rdoc,ru,gemspec}}'
  end

  private

  def files
    Dir["#{Dir.pwd}/**/#{file_pattern}"].select{|f| File.file?(f)}
  end

  def gsub_file(file)
    text = File.read(file)
    File.open(file, 'w+') do |f|
      f.write text.gsub(/#{find_pattern}/, replace_pattern)
    end
  rescue => e
    puts 'in: ' + file
    raise e
  end
end
