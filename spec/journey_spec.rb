require 'journey'

describe Journey do
  subject(:journey) { described_class.new(entry_station, exit_station) }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  it "stores two stations as a recorded journey" do
    # journey = Journey.new
    expect(journey.trip).to include(entry_station => exit_station)
  end

end
