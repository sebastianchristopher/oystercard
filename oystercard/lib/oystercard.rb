# require 'pry'
DEFAULT_BALANCE = 0
MAXIMUM_BALANCE = 90 # frozen_string_literal: true
MINIMUM_BALANCE = 1
MINIMUM_FARE = 1
PENALTY_FARE = 6
# responsible for touching in/out AND managing balance
class Oystercard
  attr_reader :balance, :journeys

  def initialize(journey_log_class = JourneyLog)
    @balance = DEFAULT_BALANCE
    @journeys = journey_log_class.new
  end

  def touch_in(station)
    deduct(PENALTY_FARE) if in_journey?
    raise 'You need more money!' if minimum?(@balance)

    @journeys.start(station)
  end

  def touch_out(station)
    @journeys.finish(station)
    deduct(@journeys.fare)
  end

  def in_journey?
    @journeys.in_journey?
  end

  def top_up(num)
    raise "#{MAXIMUM_BALANCE} is the limit" if maximum?(num)

    @balance += num
  end

  private

  def maximum?(num)
    @balance + num > MAXIMUM_BALANCE
  end
  def minimum?(num)
    @balance < MINIMUM_BALANCE
  end

  def deduct(num)
    @balance -= num
  end
end
# binding.pry
