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
    it "returns true when the journey is complete" do
      journey.start("Bank")
      journey.finish("Oval")
      expect(journey.complete?).to eq true
    end
  end

  describe "#fare" do
    it "charges penalty fare if you touch in twice" do
      journey.start("Bank")
      expect(journey.start).to change{ @balance }.by(PENALTY_CHARGE)
    end
  end
end