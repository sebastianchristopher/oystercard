require 'station'

describe Station do
  subject(:subject) { Station.new("Barbican", 1) }
  it 'has a name we can check' do
    expect(subject.name).to eq("Barbican")
  end
  it 'has a zone we can check' do
    expect(subject.zone).to eq(1)
  end
end
