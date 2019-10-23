require 'journey'

describe Journey do
  let(:card) {Oystercard.new}
  let(:journey) {Journey.new}
  let(:station) { double :station }
  let(:station2) { double :station2 }

  context "balance on card" do
    it "cannot touch in if card balance is below minimum" do
      expect{ journey.touch_in(card, station)}.to raise_error("Not enough credit to travel")
    end

    it "reduces the card balance by 1.00 when card touches out" do
      fare = -1
      expect{ journey.touch_out(card, station2)}.to change{card.balance}.by(fare)
    end
  end

    context "is the card in use?" do
      it "the card is in use" do
        expect(journey.in_journey?).to eq false
      end

      it "allows you to touch in to start a journey" do
        card.top_up(Oystercard::MIN_BALANCE)
        journey.touch_in(card, station)
        expect(journey.in_journey?).to eq true
      end

      it "remembers the station it touched out at" do
        journey.touch_out(card, station2)
        expect(card.journey_history[-1].values).to eq(station2)
      end
    end

  context "journey details" do
    it "has an empty journey history when card is spawned" do
      expect(journey.current_journey).to be_empty
    end

   before(:each) do
     card.top_up(Oystercard::MIN_BALANCE)
     journey.touch_in(card, station)
   end

    it "remembers the station it touched in at" do
      expect(journey.origin_station).to eq(station)
    end

    it "sets the origin station nil when touched out" do
      journey.touch_out(card, station2)
      expect(journey.origin_station).to eq(nil)
    end

    it "has the origin and destination stations of one trip recorded" do
      journey.touch_out(card, station2)
      expect(journey.current_journey).to eq({station => station2})
    end

  end

end
