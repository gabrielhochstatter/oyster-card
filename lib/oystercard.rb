class Oystercard

  MAXIMUM_BALANCE = 90
  attr_accessor :balance
  attr_accessor :in_journey
  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    too_high_balance_error if balance_checker(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in

    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def too_high_balance_error
    raise "You can not have more than 90 on your card"
  end

  def balance_checker(top_up_amount)
    @balance + top_up_amount > MAXIMUM_BALANCE
  end

end
