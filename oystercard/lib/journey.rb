# this is the journey class
class Journey
  attr_reader :starting_station, :exit_station
  def start_journey(station)
    @starting_station = station
  end

  def end_journey(station)
    @exit_station = station
  end

  def fare
    return PENALTY_FARE if @starting_station.nil? || @exit_station.nil?
    return (@starting_station.zone - @exit_station.zone).abs + MINIMUM_FARE
  end
end
