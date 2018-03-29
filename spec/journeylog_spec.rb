require 'journeylog'

describe JourneyLog do
  subject(:journeylog) { described_class.new }
  let(:station) { double(:station) }
  let(:other_station) { double(:station) }
  let(:journey) { double(:journey, entry_station: station, trip:({station => other_station})) }

  describe '#start' do
    before do
      journeylog.start(station)
    end

    it "sets the current_journey on starting" do
      expect(journeylog.current_journey.entry_station).to eq(station)
    end
  end

  describe '#finish' do
    before do
      journeylog.start(station)
      journeylog.finish(other_station)
    end

    it "saves the journey to the previous journeys list and sets exit_station" do
      expect(journeylog.journeys[-1].trip[station]).to eq(other_station)
    end

    it "sets the current journey back to nil" do
      expect(journeylog.current_journey).to eq(nil)
    end

    it "saves incomplete journeys" do
      
    end

  end

end
