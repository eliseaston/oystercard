class Oystercard

  BALANCE_LIMIT = 90
  MIN_BALANCE = 1

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey = nil
    @journey_history = []
  end

  # Is this needed any more?
  def in_journey?
    !!@origin_station
  end

  def top_up(credit)
    raise "Maximum balance is £#{BALANCE_LIMIT}." if (@balance + credit) > BALANCE_LIMIT
    @balance += credit
  end

  def touch_in(origin_station)
    fail "Not enough credit to travel" if @balance < MIN_BALANCE

    @journey = Journey.new
    @origin_station = origin_station
  end

  def touch_out(dest_station)
    @dest_station = dest_station
    deduct(1)
  end

# private

  def deduct(debit)
    @balance -= debit
  end

end
