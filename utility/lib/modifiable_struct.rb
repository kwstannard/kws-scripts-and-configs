require 'ostruct'

class ModifiableStruct < OpenStruct
  def method_missing(method, *args)
    raise key_error(method) unless method.to_s.end_with?('=')
    super
  end

  def key_error(name)
    NoMethodError.new "no #{name} key set yet"
  end
end
