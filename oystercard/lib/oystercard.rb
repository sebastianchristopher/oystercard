MAXIMUM_BALANCE = 90
MINIMUM_BALANCE = 1
MINIMUM_FEE = 5

class Oystercard

  attr_reader :balance, :starting_station, :exit_station, :journey_history

  def initialize
    # @starting_station = nil
    @balance = 0
    @journey_history = []
    # @in_journey = false
  end
  def top_up(num)
    fail "#{MAXIMUM_BALANCE} is the limit" if maximum?(num)
    @balance += num
  end
  def in_journey?
    @starting_station.nil? ? false : true
    # !@starting_station.nil?

    # @in_journey
  end
  def touch_in(station)
    fail "You need more money!" if @balance < MINIMUM_BALANCE
    @starting_station = station
    # @in_journey = true
  end
  def touch_out(station)
    @exit_station = station
    @journey_history.push({start: @starting_station, end: @exit_station})
    @starting_station = nil
    @exit_station = nil
    deduct(MINIMUM_FEE)
  end
  private
  def maximum?(num)
    @balance + num > MAXIMUM_BALANCE
  end
  def deduct(num)
    @balance -= num
  end
end
