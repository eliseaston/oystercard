class Oystercard

  BALANCE_LIMIT = 90
  MIN_BALANCE = 1

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(credit)
    raise "Maximum balance is £#{BALANCE_LIMIT}." if (@balance + credit) > BALANCE_LIMIT
    @balance += credit
  end

# private

  def deduct(debit)
    @balance -= debit
  end

end
