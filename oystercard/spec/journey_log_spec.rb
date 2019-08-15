require 'journey_log'

describe JourneyLog do
  let(:starting_station) { double(:starting_station) }
  let(:exit_station) { double(:exit_station) }
  let(:journey) { double(:journey, starting_station: starting_station, exit_station: exit_station) }
  let(:journey_class) { double(:journey_class, new: journey) }
  subject { described_class.new(journey_class) }
  it 'can start a new journey' do
    allow(journey).to receive(:start_journey).with(starting_station)
    expect(journey_class).to receive(:new)
    subject.start(starting_station)
  end
  it 'can record a journey' do
    allow(journey).to receive(:start_journey).with(starting_station)
    allow(journey).to receive(:end_journey).with(exit_station)
    subject.start(starting_station)
    subject.finish(exit_station)
    expect(subject.journeys).to include(journey)
  end
  it 'records an incomplete journey' do
    allow(journey).to receive(:start_journey).with(starting_station)
    subject.start(starting_station)
    subject.start(starting_station)
    expect(subject.journeys).to include(journey)
  end
end
