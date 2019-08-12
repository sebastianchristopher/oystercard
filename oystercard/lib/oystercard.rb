class Oystercard

  MAXIMUM_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end
  def top_up(num)
    fail "#{MAXIMUM_BALANCE} is the limit" if @balance + num > MAXIMUM_BALANCE
    @balance += num
  end
  def deduct(num)
    @balance -= num
  end
end
