require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new(50) }
  let(:bank) { Station.new(:bank, 1) }
  let(:waterloo) { Station.new(:waterloo, 1) }
  let(:canary_wharf) { Station.new(:canary_wharf, 2)}
  let(:brixton) { Station.new(:brixton, 2) }

  it "saves journeys correctly into previous_journeys" do
    oystercard.touch_in(bank)
    oystercard.touch_out(waterloo)
    oystercard.touch_in(waterloo)
    oystercard.touch_out(bank)
    expect(oystercard.journeylog.journeys[1].trip).to eq(waterloo => bank)
  end

  it "charges the correct amount for a Z1 to Z1 trip" do
    oystercard.touch_in(bank)
    oystercard.touch_out(waterloo)
    expect(oystercard.balance).to eq 49
  end

  it "charges the correct amout for a Z1 to Z2 trip" do
    oystercard.touch_in(waterloo)
    oystercard.touch_out(brixton)
    expect(oystercard.balance).to eq 48
  end

  it "charges the penalty fare (6) if not touched in while touching out" do
    oystercard.touch_out(bank)
    expect(oystercard.balance).to eq 44
  end

  it "charges penalty fare if touching in without being touched out" do
    oystercard.touch_in(bank)
    oystercard.touch_in(waterloo)
    expect(oystercard.balance).to eq 44
  end


end
