require "oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it "should know if it's on a journey" do
    expect(oystercard.in_journey?).not_to be
  end

  describe "#touch_in" do
    it "should change journey status to true when touching in" do
      oystercard.top_up(5)
      oystercard.touch_in
      expect(oystercard.in_journey?).to be
    end

    it 'should let you touch in if you dont have £1 on your card' do
      message = "You can not travel with less than £1"
      empty_card = Oystercard.new(0)
      expect { empty_card.touch_in }.to raise_error message
    end

  end

  describe "#touch_out" do
    it "should change journey status to false when touching out" do
      oystercard.touch_out
      expect(oystercard.in_journey?).not_to be
    end

    it 'should deduct £1 from the card when you touch out' do
      oystercard.top_up(5)
      oystercard.touch_in
      expect {oystercard.touch_out}.to change{oystercard.balance}.by(-1)
    end
  end


  describe '#top_up' do
    it "adds funds when topping up" do
      oystercard.top_up(10)
      expect(oystercard.balance).to eq 10
    end


    it "errors when too much money" do
      message = "You can not have more than 90 on your card"
      oystercard.balance = 90
      expect { oystercard.top_up(1) }.to raise_error message
    end
  end

  describe '#deduct' do

  end


end
