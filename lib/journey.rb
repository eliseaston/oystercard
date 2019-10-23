require_relative 'oystercard'

class Journey

  attr_reader :current_journey, :origin_station, :dest_station

  def initialize
    @current_journey = {}
    @fare = 1
  end

  def in_journey?
    !!@origin_station
  end

  def touch_in(card, origin_station)
    fail "Not enough credit to travel" if card.balance < Oystercard::MIN_BALANCE
    @origin_station = origin_station
  end

  def touch_out(card, dest_station)
    save_journey_history(card, dest_station)
  end

  # private

  def save_journey_history(card, dest_station)
    @dest_station = dest_station
    @current_journey = {@origin_station => @dest_station}
    card.deduct(@fare)
    card.journey_history << @current_journey
    @origin_station = nil
    @dest_station = nil
  end

end
