require_relative '../lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }
    
    it 'card has default balance of 0' do
      expect(oystercard.balance).to eq(0)
    end
  
  describe "#topup" do
    it { is_expected.to respond_to(:topup).with(1).argument }

    it "should add money to card" do
      expect{ oystercard.topup 5 }.to change{ oystercard.balance }.by 5
    end

    it "throw an error if balance exceeds 90" do
      expect{ oystercard.topup 91 }.to raise_error("balance limit exceeded")
    end

  end
end


