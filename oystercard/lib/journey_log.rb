# JourneyLog class, holds journeys, starts and ends them by instantiating new Journey
class JourneyLog
  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @journeys << @current_journey if in_journey?
    current_journey.start_journey(station)
  end

  def finish(station)
    current_journey.end_journey(station)
    @journeys << @current_journey
    @current_journey = nil
  end

  def fare
    @journeys.last.fare
  end

  def in_journey?
    !@current_journey.nil?
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey
    @current_journey ||= @journey_class.new
  end
end
