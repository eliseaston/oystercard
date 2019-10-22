require 'oystercard'

class Journey

  attr_reader :journey_history, :origin_station, :dest_station

  def initialize
    @journey_history = {}
  end

  def in_journey?
    !!@origin_station
  end

  def touch_in(card, origin_station)
    fail "Access denied. Card balance below min." unless card.balance >= Oystercard::MIN_BALANCE
    @origin_station = origin_station
  end

  def touch_out(card, dest_station)
    card.deduct(1)
    @dest_station = dest_station
    save_journey_history
  end

  private

  def save_journey_history
    @journey_history.store(@origin_station, @dest_station)
    @origin_station = nil
  end

end
