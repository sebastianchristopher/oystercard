require 'journey_log'

describe JourneyLog do
  let(:starting_station) { double(:starting_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { double(:journey, starting_station: starting_station, exit_station: exit_station) }
  let(:journey_class) { double(:journey_class, new: journey) }
  subject { described_class.new(journey_class) }
  xit 'can start a journey' do
    allow(journey).to receive(:start_journey).with(starting_station)
    subject.start(starting_station)
    expect(subject.current_journey.starting_station).to eq(starting_station)
  end
  it 'can end a journey' do
    allow(journey).to receive(:start_journey).with(starting_station)
    allow(journey).to receive(:end_journey).with(exit_station)
    subject.start(starting_station)
    subject.finish(exit_station)
    expect(subject.journeys.last.exit_station).to eq(exit_station)
  end
  it 'returns a list of journeys' do
    allow(journey).to receive(:start_journey).with(starting_station)
    allow(journey).to receive(:end_journey).with(exit_station)
    subject.start(starting_station)
    subject.finish(exit_station)
    # subject.start(double(:starting_station))
    # subject.end(double(:exit_station))
    expect(subject.journeys).to include(journey)
  end
end
