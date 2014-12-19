require File.expand_path("..", __FILE__)+ '/return_same'
class Foo
  extend ReturnSame

  def initialize(str)
    @str = str
  end

  attr_reader :str

  def foo; "foo"; end
  return_same :foo
end

describe ReturnSame do
  it "returns a new object of the same class" do
    Foo.new('hi').foo.should be_a Foo
    Foo.new('hi').foo.str.should eq 'foo'
  end
end
