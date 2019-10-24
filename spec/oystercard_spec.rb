require 'oystercard'
require 'journey'

describe Oystercard do
  let(:card) {Oystercard.new}
  let(:journey) {Journey.new}
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

    it "cannot touch in if card balance is below minimum" do
      expect{ card.touch_in(station)}.to raise_error("Not enough credit to travel")
    end

    it "reduces the card balance by 1.00 when card touches out" do
      fare = -1
      expect{ card.touch_out(station2)}.to change{card.balance}.by(fare)
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

  end

  context "journey details" do
    it "new card has an empty journey history" do
      expect(card.journey_history).to be_empty
    end
  end

end
