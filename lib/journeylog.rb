class JourneyLog
  attr_reader :current_journey

  def initialize

    @previous_journeys = []
    @current_journey = nil
  end

  def start(entry_station)
    @current_journey = Journey.new(entry_station)
  end

  def finish(exit_station)
    @current_journey.end_journey(exit_station)
    @previous_journeys << @current_journey
    @current_journey = nil
  end

  def journeys
    @previous_journeys.dup
  end

end
