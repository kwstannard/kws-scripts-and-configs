module ReturnSame
  def return_same(*methods)
    methods.each do |method|
      class_eval <<-METHOD
        alias __return_same_#{method} #{method}

        def #{method} *args, &block
          self.class.new(__return_same_#{method}(*args, &block))
        end
      METHOD
    end
  end
end
