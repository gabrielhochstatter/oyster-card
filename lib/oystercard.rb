class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  FARE = 1
  attr_accessor :balance
  attr_accessor :entry_station
  def initialize(balance = 0)
    @balance = balance
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
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(FARE)
    @entry_station = nil
  end

  private

  def too_high_balance_error
    raise "You can not have more than 90 on your card"
  end

  def balance_too_high(top_up_amount)
    @balance + top_up_amount > MAXIMUM_BALANCE
  end

  def too_low_balance_error
    raise "You can not travel with less than £1"
  end

  def balance_too_low?
    @balance < MINIMUM_BALANCE
  end

  def deduct(amount)
    @balance -= amount
  end
end
