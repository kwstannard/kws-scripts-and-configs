Neovim.plugin do |plug|
  plug.function(:ConvertLet, sync: true) do |nvim|
    line = nvim.current.line
    if line.match(/\w+ ?=/)
      nvim.current.line = line.gsub(/(\w+) ?= ?(.*)/, 'let(:\1) { \2 }')
    elsif line.match(/let\(:/)
      nvim.current.line = line.gsub(/let\(:(\w+)\) { (.*) }/, '\1 = \2')
    end
  end
end
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
