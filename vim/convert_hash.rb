class ConvertHash
  def call
    line = VIM::Buffer.current.line
    if line.match(/:\w+ ?=>/)
      VIM::Buffer.current.line = line.gsub(/:(\w+) ?=> ?(.*?),?/, '\1: \2')
    elsif line.match(/\w+: /)
      VIM::Buffer.current.line = line.gsub(/(\w+): (.*?),?/, ':\1 => \2')
    end
  end
end
