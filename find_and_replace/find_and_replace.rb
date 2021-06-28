require 'pathname'
class FindAndReplacePath < Struct.new(:find_pattern, :replace_pattern)
  def call
    puts "#{find_pattern.inspect} => #{replace_pattern.inspect}"

    files.tap{|x| puts x.join(' : ') }.each do |file|
      %x(git mv #{file} #{file.to_s.gsub(find_pattern, replace_pattern)})
    end
  end

  private

  def files
    Pathname.glob(Pathname.pwd.join("**/*")).select{|p| p.to_s.match find_pattern}
  end
end

class FindAndReplaceText < Struct.new(:find_pattern, :replace_pattern)
  def call
    puts "#{find_pattern.inspect} => #{replace_pattern.inspect}"
    files.each do |file|
      gsub_file(file)
    end
  end

  private

  def files
    `rg --files -truby -tjs -thtml -ttxt -treadme -tjson -tmd -tyaml`.split("\n")
  end

  def gsub_file(file)
    text = File.read(file)
    File.open(file, 'w+') do |f|
      f.write text.gsub(find_pattern, replace_pattern)
    end
  rescue => e
    require 'pry';binding.pry
    puts 'in: ' + file
    raise e
  end
end
