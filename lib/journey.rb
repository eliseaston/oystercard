require_relative 'oystercard'

class Journey

  attr_reader :current_journey, :fare #:origin_station, :dest_station

  def initialize
    @current_journey = {}
    @fare = 1
  end

  # private

  def save_journey_history(card, dest_station)
    @current_journey = {origin: @origin_station, destination: @dest_station}
    card.deduct(@fare)
    card.journey_history << @current_journey
  end

end
