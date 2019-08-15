require 'journey'
describe Journey do
  let(:starting_station) { double(:starting_station, zone: 1) }
  let(:exit_station) { double(:exit_station, zone: 1) }
  let(:zone_2_station) { double(:zone_2_station, zone: 2) }
  let(:zone_3_station) { double(:zone_3_station, zone: 3) }
  let(:zone_4_station) { double(:zone_4_station, zone: 4) }
  context 'when starting and ending journeys' do
    it 'can start a journey' do
      expect(subject).to receive(:start_journey).with(starting_station)
      subject.start_journey(starting_station)
    end
    it 'can end a journey' do
      expect(subject).to receive(:end_journey).with(exit_station)
      subject.end_journey(exit_station)
    end
  end
  context 'when calculating fare' do
    it 'deducts the minimum fare if both stations are in same zone' do
      subject.start_journey(starting_station)
      subject.end_journey(exit_station)
      expect(subject.calculate_fare).to eq(MINIMUM_FARE)
    end
    it 'deducts the penalty fare if there is not a start station' do
      subject.end_journey(exit_station)
      expect(subject.calculate_fare).to eq(PENALTY_FARE)
    end
    it 'deducts the penalty fare if there is not an end station' do
      subject.start_journey(starting_station)
      expect(subject.calculate_fare).to eq(PENALTY_FARE)
    end
    it 'fare is 2 when going from zone 3 to zone 4' do
      subject.start_journey(zone_3_station)
      subject.end_journey(zone_4_station)
      expect(subject.calculate_fare).to eq(2)
    end
    it 'fare is 3 when going from zone 4 to zone 2' do
      subject.start_journey(zone_4_station)
      subject.end_journey(zone_2_station)
      expect(subject.calculate_fare).to eq(3)
    end
  end
end
