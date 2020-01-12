require 'tempfile'
RSpec.describe 'de' do
  it 'works' do
    Dir.chdir(Dir.tmpdir)
    File.write('.env', <<~FILE)
      HELLO=WORLD
      quote=in'"string
      Goodbye='moon'
      multi='line"
      string'
      # comment
      string="multi'
      lines"
    FILE

    expect(Marshal.load(`env -i $(which de) ruby -e "puts Marshal.dump(ENV.to_h)"`))
      .to include(
        "HELLO"=>"WORLD",
        "quote"=>"in'\"string",
        "Goodbye"=>"moon",
        "multi"=>"line\"\nstring",
        "string"=>"multi'\nlines",
      )
  end
end
