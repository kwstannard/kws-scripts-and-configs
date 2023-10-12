require 'tempfile'
RSpec.describe 'de' do
  it 'works' do
    Dir.chdir(Dir.tmpdir)
    File.write('.env', <<~FILE)
      HELLO=WORLD
      ignored invalid line
      quote=in'"string
      Goodbye='moon'
      multi='line"
      string'
      # comment
      string="multi'
      lines"
    FILE

    # $(which de) will return the absolute path to de
    # env -i runs something with a clear env
    # the string interpolation will happen before env clearing.
    expect(Marshal.load(`env -i $(which de) ruby -e "puts Marshal.dump(ENV.to_h)"`))
      .to match(
        "HELLO"=>"WORLD",
        "quote"=>"in'\"string",
        "Goodbye"=>"moon",
        "multi"=>"line\"\nstring",
        "string"=>"multi'\nlines",
        "__CF_USER_TEXT_ENCODING" => "0x1F6:0x0:0x0",
      )
  end
end
