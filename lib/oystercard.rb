require_relative 'journey'
require_relative 'station'
require_relative 'journeylog'

class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  LOW_FARE = 1
  HIGH_FARE = 2
  PENALTY_FARE = 6
  NO_STATION = :no_station
  attr_reader :balance, :entry_station, :previous_journeys, :journeylog
  def initialize(balance = 0)
    @balance = balance
    @previous_journeys = []
    @journeylog = JourneyLog.new
    @entry_station = nil
  end

  def top_up(amount)
    too_high_balance_error if balance_too_high(amount)
    @balance += amount
  end

  def in_journey?
    true unless @entry_station.nil?
  end

  def touch_in(station)
    too_low_balance_error if balance_too_low?
    touch_in_helper(station)
  end

  def touch_out(exit_station)
    touch_out_helper(exit_station)
    @entry_station = nil
  end

  private

  # ERROR MESSAGES
  def too_high_balance_error
    raise "You can not have more than 90 on your card"
  end

  def too_low_balance_error
    raise "You can not travel with less than £1"
  end

  # CHECKERS
  def balance_too_high(top_up_amount)
    @balance + top_up_amount > MAXIMUM_BALANCE
  end

  def balance_too_low?
    @balance < MINIMUM_BALANCE
  end

  # HELPER METHODS
  def penalty_fare
    deduct(PENALTY_FARE)
  end

  def touch_in_helper(entry_station)
    if in_journey?
      penalty_fare
      @journeylog.finish(NO_STATION)
    else
    @journeylog.start(entry_station)
    # @current_journey = Journey.new(entry_station)
    @entry_station = entry_station
    end
  end

  def touch_out_helper(exit_station)
    unless in_journey?
      @journeylog.start(NO_STATION)
      @journeylog.finish(exit_station)
      penalty_fare
    else
      @journeylog.finish(exit_station)
      @previous_journeys << @current_journey
      fare(exit_station)
    end
    @current_journey = nil
  end

  def fare(exit_station)
    if zone_comparison?(@entry_station, exit_station)
      deduct(LOW_FARE)
    else
      deduct(HIGH_FARE)
    end
  end

  def zone_comparison?(entry_station, exit_station)
    entry_station.zone == exit_station.zone
  end

  def deduct(amount)
    @balance -= amount
  end
end
