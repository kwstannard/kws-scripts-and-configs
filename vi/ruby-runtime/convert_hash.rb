class ConvertHash < Struct.new(:client)
  def call
    line = client.current.line
    if line.match(/:\w+ ?=>/)
      client.current.line = line.gsub(/[:"](\w+)"? ?=> ?(.*?),?/, '\1: \2')
    elsif line.match(/\w+: /)
      client.current.line = line.gsub(/(\w+): (.*?),?/, '"\1" => \2')
    end
  end
end

require 'neovim'
vim_socket = UNIXSocket.new(ENV["NVIM_LISTEN_ADDRESS"])
client = Neovim::Client.new(vim_socket)

client.message "hello"

ConvertHash.new(client)
