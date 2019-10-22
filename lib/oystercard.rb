class Oystercard

  BALANCE_LIMIT = 90
  MIN_BALANCE = 1

  attr_reader :balance, :origin_station, :dest_station, :journey_history

  def initialize
    @balance = 0
    @in_journey = false
    @journey_history = {}
  end

  def top_up(credit)
    new_balance = @balance += credit
    raise "Maximum balance is £#{BALANCE_LIMIT}." if new_balance > BALANCE_LIMIT

    @balance = new_balance
  end

  def in_journey?
    !!@origin_station
  end


  def touch_in(origin_station)
    fail "Access denied. Card balance below min." unless @balance >= MIN_BALANCE
    @origin_station = origin_station
  end

  def touch_out(dest_station)
    deduct(1)
    @dest_station = dest_station
    save_journey_history
    @origin_station = nil
  end


private

  def deduct(debit)
    @balance -= debit
  end

 def save_journey_history
   @journey_history.store(@origin_station, @dest_station)
 end


end
