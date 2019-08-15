require './lib/oystercard'
describe Oystercard do
  let(:station) { double(:station, zone: 1) }
  let(:exit_station) { double(:exit_station, zone: 1) }
  let(:journey_log) { double(:journey_log) }
  let(:journey_log_class) { double(:journey_log_class, new: journey_log) }
  subject { described_class.new(journey_log_class) }

  context 'balance' do
    it 'has a default balance' do
      expect(subject.balance).to eq(DEFAULT_BALANCE)
    end
    context '#top_up' do
      it 'can increase balance' do
        expect { subject.top_up(1) }.to change {subject.balance }.by(1)
      end
      it 'raises error at limit' do
        subject.top_up(MAXIMUM_BALANCE)
        expect { subject.top_up(1) }.to raise_error("#{MAXIMUM_BALANCE} is the limit")
      end
    end
    context '#deduct' do
      it 'deducts balance' do
        allow(journey_log).to receive(:start).with(station)
        allow(journey_log).to receive(:finish).with(exit_station)
        allow(journey_log).to receive(:fare).and_return(1)
        allow(journey_log).to receive(:in_journey?).and_return(false)
        subject.top_up(1)
        subject.touch_in(station)
        subject.touch_out(exit_station)
        expect(subject.balance).to eq(0)
      end
    end
  end

  context 'when touching in' do
    it 'can touch in, starting journey' do
      allow(journey_log).to receive(:start).with(station)
      allow(journey_log).to receive(:in_journey?).and_return(false)
      subject.top_up(1)
      subject.touch_in(station)
      allow(journey_log).to receive(:in_journey?).and_return(true)
      expect(subject).to be_in_journey
    end
    it 'raises an error at lower limit' do
      allow(journey_log).to receive(:in_journey?).and_return(false)
      expect { subject.touch_in(station) }.to raise_error('You need more money!')
    end
  end
  context 'when touching out' do
    it 'can touch out, end journey' do
      allow(journey_log).to receive(:start).with(station)
      allow(journey_log).to receive(:finish).with(exit_station)
      allow(journey_log).to receive(:fare).and_return(1)
      allow(journey_log).to receive(:in_journey?).and_return(false)
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out(exit_station)
      expect(subject).to_not be_in_journey
    end
    it 'deducts at least the minimum fee' do
      allow(journey_log).to receive(:start).with(station)
      allow(journey_log).to receive(:finish).with(exit_station)
      allow(journey_log).to receive(:fare).and_return(MINIMUM_FARE)
      allow(journey_log).to receive(:in_journey?).and_return(false)
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-MINIMUM_FARE)
    end
  end
  context 'when not touched in or out' do
    it 'charges the penalty fee when touching in again if not touched out' do
      allow(journey_log).to receive(:start).with(station)
      allow(journey_log).to receive(:in_journey?).and_return(false)
      subject.top_up(20)
      subject.touch_in(station)
      allow(journey_log).to receive(:in_journey?).and_return(true)
      expect { subject.touch_in(station) }.to change { subject.balance }.by(-PENALTY_FARE)
    end
  end
end
