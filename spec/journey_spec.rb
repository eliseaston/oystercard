require 'journey'

describe Journey do
  let(:card) {Oystercard.new}
  let(:journey) {Journey.new}
  let(:station) { double :station }
  let(:station2) { double :station2 }

  context "journey details" do

    it "saves the origin station when a journey is started" do
      journey.start(station)
      expect(journey.origin_station).to eq(station)

    xit "has the origin and destination stations of one trip recorded" do
      card.top_up(Oystercard::MIN_BALANCE)
      card.touch_in(station)
      card.touch_out(station2)
      expect(journey.current_journey).to eq({origin: station, destination: station2})
    end

  end

end
