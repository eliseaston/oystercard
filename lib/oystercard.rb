class Oystercard

  BALANCE_LIMIT = 90
  MIN_BALANCE = 1

  attr_reader :balance, :origin_station, :dest_station, :journey_history

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(credit)
    new_balance = @balance += credit
    raise "Maximum balance is £#{BALANCE_LIMIT}." if new_balance > BALANCE_LIMIT

    @balance = new_balance
  end

# private

  def deduct(debit)
    @balance -= debit
  end

end
