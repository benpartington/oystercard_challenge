require_relative '../lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }
    
    it 'card has default balance of 0' do
      expect(oystercard.balance).to eq(0)
    end
  
  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "should add money to card" do
      expect{ oystercard.top_up(5) }.to change{ oystercard.balance }.by(5)
    end

    it "throw an error if balance exceeds £90" do
      limit = Oystercard::LIMIT
      oystercard.top_up(limit)
      expect{ oystercard.top_up(1) }.to raise_error "balance exceeded limit of #{limit}"
    end
  end
  
  describe "#touch_in" do
    it 'should touch in' do
      oystercard.top_up(5)
      oystercard.touch_in
      expect( oystercard.in_journey? ).to eq true
    end

    it 'should error if insufficient funds' do
      min = Oystercard::MIN 
      expect{ oystercard.touch_in }.to raise_error "insufficient funds, balance less than #{min}"
    end
  end

  describe "#in_journey?" do
    it 'should tell us if the user is on a journey' do
      oystercard.top_up(5)
      oystercard.touch_in
      expect( oystercard.in_journey?).to eq true
    end
  end

  describe "#touch_out" do
    it 'should touch out' do
      oystercard.top_up(5)
      oystercard.touch_in
      oystercard.touch_out
      expect( oystercard.in_journey? ).to eq false
    end    
    it 'should deduct on touch out' do
      oystercard.top_up(5)
      oystercard.touch_in
      oystercard.touch_out
      min = Oystercard::MIN
      expect{ oystercard.touch_out }.to change{ oystercard.balance }.by(-min)
    end
  end
end
