MAXIMUM_BALANCE = 90 # frozen_string_literal: true
MINIMUM_BALANCE = 1
MINIMUM_FEE = 5
# Oystercard class
class Oystercard
  attr_reader :balance, :starting_station, :exit_station, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(num)
    raise "#{MAXIMUM_BALANCE} is the limit" if maximum?(num)

    @balance += num
  end

  def in_journey?
    @starting_station.nil? ? false : true
  end

  def touch_in(station)
    raise 'You need more money!' if @balance < MINIMUM_BALANCE
    @journey
    @starting_station = station
  end

  def touch_out(station)
    @exit_station = station
    store_journey_history
    @starting_station = nil
    @exit_station = nil
    deduct(MINIMUM_FEE)
  end

  def store_journey_history
    @journey_history.push(start: @starting_station, end: @exit_station)
  end

  private

  def maximum?(num)
    @balance + num > MAXIMUM_BALANCE
  end

  def deduct(num)
    @balance -= num
  end
end
