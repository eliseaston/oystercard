class Oystercard

  BALANCE_LIMIT = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(credit)
    new_balance = @balance += credit
    raise "Maximum balance is £#{BALANCE_LIMIT}." if new_balance > BALANCE_LIMIT

    @balance = new_balance
  end

  def deduct(debit)
    @balance -= debit
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

end
