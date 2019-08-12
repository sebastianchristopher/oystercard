class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end
  def top_up(num)
    fail "£90 is the limit" if @balance + num > 90
    @balance = @balance  + num
  end
end
