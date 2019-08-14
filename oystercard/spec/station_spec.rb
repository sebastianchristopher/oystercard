require 'station'

describe Station do
  it 'has a name we can check' do
    station = Station.new("Barbican", 1)
    expect(station.name).to eq("Barbican")
  end
  it 'has a zone we can check' do
    station = Station.new("Barbican", 1)
    expect(station.zone).to eq(1)
  end
end
