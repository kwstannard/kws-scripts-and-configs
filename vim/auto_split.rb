class AutoSplit
  def initialize(window)
    @window = window
  end

  def call
    if @window.width > 160
      ":vsplit"
    else
      ":split"
    end
  end
end
