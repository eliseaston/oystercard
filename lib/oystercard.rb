class Oystercard

  BALANCE_LIMIT = 90
  MIN_BALANCE = 1

  attr_reader :balance

  def initialize
    @balance = 0
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
