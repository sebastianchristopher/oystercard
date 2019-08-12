class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end
  def top_up(num)
    fail "£90 is the limit" if @balance + num > MAXIMUM_BALANCE
    @balance = @balance  + num
  end
end
