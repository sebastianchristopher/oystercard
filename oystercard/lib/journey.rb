class Journey
  attr_reader :starting_station, :exit_station
  def start_journey(station)
    @starting_station = station
  end
  def end_journey(station)
    @exit_station = station
  end
end
