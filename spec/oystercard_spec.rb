require 'oystercard'

describe Oystercard do
  let(:card) {Oystercard.new}
  let(:station) { double :station }
  let(:station2) { double :station2 }

  context "balance on card" do
    it "has a balance" do
      expect(card.balance).to eq 0
    end

    it "allows you to add money to the card" do
      card.top_up(1)
      expect(card.balance).to eq(1)
    end

    it "doesn't allow you to add more money than the limit to the card" do
      expect{ card.top_up(100) }.to raise_error("Maximum balance is £#{Oystercard::BALANCE_LIMIT}.")
    end

    it "gets blocked by the gateline if the balance is below minimum" do
      expect{ card.touch_in(station)}.to raise_error("Access denied. Card balance below min.")
    end

    it "reduces the card balance by 1.00 when card touches out" do
      expect{ card.touch_out(station2)}.to change{card.balance}.by(-1)
    end


  end

  context "is the card in use?" do
    it "the card is in use" do
      expect(card.in_journey?).to eq false
    end

    it "allows you to touch in to start a journey" do
      card.top_up(Oystercard::MIN_BALANCE)
      card.touch_in(station)
      expect(card.in_journey?).to eq true
    end

    it "remembers the station it touched out at" do
      card.touch_out(station2)
      expect(card.dest_station).to eq(station2)
    end
  end

  context "journey details" do
    it "has an empty journey history when card is spawned" do
      expect(card.journey_history).to be_empty
    end

   before(:each) do
     card.top_up(Oystercard::MIN_BALANCE)
     card.touch_in(station)
   end

    it "remembers the station it touched in at" do
      expect(card.origin_station).to eq(station)
    end

    it "sets the origin station nil when touched out" do
      card.touch_out(station2)
      expect(card.origin_station).to eq(nil)
    end

    it "has the origin and destination stations of one trip recorded" do
      card.touch_out(station2)
      expect(card.journey_history).to eq({station => station2})
    end

  end

end
