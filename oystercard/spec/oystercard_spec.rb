require './lib/oystercard'
describe Oystercard do
  it 'can have a default balance of 0' do
    expect(subject.balance).to eq(0)
  end
  it 'can respond to top_up' do
    expect(subject).to respond_to(:top_up).with(1).argument
  end
  describe '#top_up' do
    it 'can increase balance' do
      expect(subject.top_up(10)).to eq(10)
    end
    it 'can raise error at limit' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error("£90 is the limit")
    end
  end
end
