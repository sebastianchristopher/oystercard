# this is the journey class
class Journey
  attr_reader :starting_station, :exit_station
  def start_journey(station)
    @starting_station = station
  end

  def end_journey(station)
    @exit_station = station
  end

  def completed_journey
    { start: @starting_station, end: @exit_station }
  end
end
