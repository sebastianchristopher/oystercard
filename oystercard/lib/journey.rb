# responsible for individual journeys, AND charging fare
class Journey
  attr_reader :fare
  def initialize
    @fare = 0
  end

  def start_journey(station)
    @starting_station = station
  end

  def end_journey(station)
    @exit_station = station
    @fare = calculate_fare
  end

  def calculate_fare
    return PENALTY_FARE if @starting_station.nil? || @exit_station.nil?
    return (@starting_station.zone - @exit_station.zone).abs + MINIMUM_FARE
  end
end
