class Journey

  attr_accessor :trip

  def initialize(entry_station, exit_station)
    @trip = { entry_station => exit_station }

  end

end
