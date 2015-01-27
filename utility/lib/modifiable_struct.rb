require 'ostruct'

# ModifiableStruct is a variation on OpenStruct where and variable get for an
# unset variable will result in a NoMethodError. This allows you to safely add
# and get variables without having to track down nils introduced by bad method
# calls.

class ModifiableStruct < OpenStruct
  def method_missing(method, *args)
    raise key_error(method) unless method.to_s.end_with?('=')
    super
  end

  def key_error(name)
    NoMethodError.new "no #{name} key set yet"
  end
end
