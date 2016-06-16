require_relative 'modifiable_struct'

# ClosedStruct is a variation on OpenStruct where the original hash is the
# final form the struct can take. In practice it is like a Struct where you
# define variables at initialization instead of when the class is loaded.

class ClosedStruct < ModifiableStruct
  protected

  def method_missing(method, *args, &block)
    raise NoMethodError, "no #{method.to_s.chomp('='.freeze)} key set on initialization"
  end
end
