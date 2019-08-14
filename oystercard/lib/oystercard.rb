# require 'pry'
MAXIMUM_BALANCE = 90 # frozen_string_literal: true
MINIMUM_BALANCE = 1
MINIMUM_FARE = 1
PENALTY_FARE = 6
# Oystercard class
class Oystercard
  attr_reader :balance, :starting_station, :exit_station, :journeys

  def initialize
    @balance = 0
    @journeys = JourneyLog.new
  end

  def top_up(num)
    raise "#{MAXIMUM_BALANCE} is the limit" if maximum?(num)

    @balance += num
  end

  def touch_in(station)
    raise 'You need more money!' if minimum?(@balance)

    @journeys.start(station)
  end

  def touch_out(station)
    @journeys.finish(station)
    deduct(@journeys.fare)
  end

  def in_journey?
    @journeys.in_journey? ? false : true
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
