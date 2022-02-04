require_relative '../lib/journey.rb'

describe Journey do
  subject(:journey) { described_class.new }
  let(:kings_cross) { Station.new("King's Cross", 1) }
  describe "#start" do
    it "records the entry station" do
      expect(journey.start(kings_cross)).to eq(kings_cross)
    end
  end

  describe "#finish" do

  end

  describe "#complete?" do

  end

  describe "#fare" do

  end

end