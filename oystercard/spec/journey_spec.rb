require 'journey'
# require 'oystercard'
describe Journey do
  let(:starting_station) { double(:starting_station, zone: 1) }
  let(:exit_station) { double(:exit_station, zone: 1) }
  let(:zone_2_station) { double(:zone_2_station, zone: 2) }
  let(:zone_3_station) { double(:zone_3_station, zone: 3) }
  let(:zone_4_station) { double(:zone_4_station, zone: 4) }
  it 'has a start station we can check' do
    subject.start_journey(starting_station)
    expect(subject.starting_station).to eq(starting_station)
  end
  it 'has a exit station we can check' do
    subject.start_journey(starting_station)
    subject.end_journey(exit_station)
    expect(subject.exit_station).to eq(exit_station)
  end
  xit 'can return a completed journey with start and end stations' do
    subject.start_journey(starting_station)
    subject.end_journey(exit_station)
    expect(subject.completed_journey).to eq({ start: starting_station, end: exit_station })
  end
  it 'deducts the minimum fare if both stations are in same zone' do
    subject.start_journey(starting_station)
    subject.end_journey(exit_station)
    expect(subject.fare).to eq(MINIMUM_FARE)
  end
  it 'deducts the penalty fare if there is not a start station' do
    subject.end_journey(exit_station)
    expect(subject.fare).to eq(PENALTY_FARE)
  end
  it 'deducts the penalty fare if there is not an end station' do
    subject.start_journey(starting_station)
    expect(subject.fare).to eq(PENALTY_FARE)
  end
  it 'fare is 2 when going from zone 3 to zone 4' do
    subject.start_journey(zone_3_station)
    subject.end_journey(zone_4_station)
    expect(subject.fare).to eq(2)
  end
  it 'fare is 3 when going from zone 4 to zone 2' do
    subject.start_journey(zone_4_station)
    subject.end_journey(zone_2_station)
    expect(subject.fare).to eq(3)
  end
end
