class Journey

  attr_accessor :trip, :entry_station, :exit_station

  def initialize(entry_station, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @trip = { entry_station => exit_station }
  end

  def end_journey(exit_station)
    @trip[entry_station] = exit_station
  end

end
