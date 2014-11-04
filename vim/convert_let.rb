class ConvertLet
  def call
    line = VIM::Buffer.current.line
    if line.match(/\w+ ?=/)
      VIM::Buffer.current.line = line.gsub(/(\w+) ?= ?(.*)/, 'let(:\1) { \2 }')
    elsif line.match(/let\(:/)
      VIM::Buffer.current.line = line.gsub(/let\(:(\w+)\) { (.*) }/, '\1 = \2')
    end
  end
end
