require_relative '../lib/station.rb'

describe Station do
  let(:station) { Station.new("Bank", 1) }
  
  describe "#zone" do
    it 'should output the zone' do
      expect(station.zone).to eq 1
    end
  end
  
  describe "#name" do
    it 'should output the name' do
      expect(station.name).to eq "Bank"
    end
  end
end

