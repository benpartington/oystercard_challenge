require_relative '../lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }
    
    it 'card has default balance of 0' do
      expect(oystercard.balance).to eq(0)
    end
  
  describe "#topup" do
    it { is_expected.to respond_to(:topup).with(1).argument }

    it "should add money to card" do
      expect{ oystercard.topup(5) }.to change{ oystercard.balance }.by(5)
    end

    it "throw an error if balance exceeds 90" do
      limit = Oystercard::LIMIT
      oystercard.topup(limit)
      expect{ oystercard.topup 1 }.to raise_error "balance exceeded limit of #{limit}"
    end
  end

  describe "#deduct" do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'should deduct money from card' do
      oystercard.topup(10)
      expect{ oystercard.deduct(5) }.to change{ oystercard.balance }.by(-5)
    end
  end  
end


