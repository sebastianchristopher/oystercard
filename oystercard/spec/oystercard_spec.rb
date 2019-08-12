require './lib/oystercard'
describe Oystercard do
  it 'can have a default balance of 0' do
    expect(subject.balance).to eq(0)
  end
end
