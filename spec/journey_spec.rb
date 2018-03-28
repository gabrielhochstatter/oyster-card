require 'journey'

describe Journey do
  # subject(:journey) { described_class.new }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  it "stores two stations as a recorded journey" do
    journey = Journey.new(entry_station, exit_station)
    expect(journey.trip).to include(entry_station => exit_station)
  end

end
