require_relative 'modifiable_struct'

class ClosedStruct < ModifiableStruct
  def initialize(*args)
    super
  end

  protected

  def method_missing(method, *args, &block)
    raise NoMethodError, "no #{method.to_s.chomp('='.freeze)} key set on initialization"
  end
end
