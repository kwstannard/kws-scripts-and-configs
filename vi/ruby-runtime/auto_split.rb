class AutoSplit
  def initialize(window)
    @window = window
  end

  def call
    if @window.width > 170
      ":vsplit"
    else
      ":split"
    end
  end
end
