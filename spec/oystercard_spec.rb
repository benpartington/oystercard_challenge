require_relative '../lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:kings_cross) { double("King's Cross") }
  let(:bank) { double("Bank") }
    
    it 'card has default balance of 0' do
      expect(oystercard.balance).to eq(0)
    end
  
  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "should add money to card" do
      expect{ oystercard.top_up(5) }.to change{ oystercard.balance }.by(5)
    end
    
    context "balance exceeds top up limit" do
      it "should error" do
        limit = Oystercard::LIMIT
        oystercard.top_up(limit)
        expect{ oystercard.top_up(1) }.to raise_error "balance exceeded limit of #{limit}"
      end
    end
  end
  
  describe "#touch_in" do
    context "After touch in" do
      it 'should touch in' do
        oystercard.top_up(5)
        oystercard.touch_in(:kings_cross)
        expect( oystercard.in_journey? ).to eq true
      end
      
      it 'should remember the entry station' do
        oystercard.top_up(5)
        oystercard.touch_in(:kings_cross)
        expect(oystercard.entry_station).to eq(:kings_cross)
      end
    end

    context "insufficient funds" do
      it 'should error' do
        min = Oystercard::MIN 
        expect{ oystercard.touch_in(:kings_cross) }.to raise_error "insufficient funds, balance less than #{min}"
      end
    end
  end

  describe "#in_journey?" do
    it 'should tell us if the user is on a journey' do
      oystercard.top_up(5)
      oystercard.touch_in(:kings_cross)
      expect( oystercard.in_journey?).to eq true
    end
  end

  describe "#touch_out" do
    context "after touch out" do

      before(:each) do
        oystercard.top_up(5)
        oystercard.touch_in(:kings_cross)
        oystercard.touch_out(:bank)
      end

      it 'should touch out' do
        expect( oystercard.in_journey? ).to eq false
      end 

      it 'should deduct funds' do
        min = Oystercard::MIN
        expect{ oystercard.touch_out(:bank) }.to change{ oystercard.balance }.by(-min)
      end

      it 'should set entry station to nil' do
        expect(oystercard.entry_station).to eq(nil)
      end
    end
  end
  
  it "should store a journey as a hash" do
    test_journey = {:entry_station => :kings_cross, :exit_station => :bank}

    oystercard.top_up(5)
    oystercard.touch_in(:kings_cross)
    oystercard.touch_out(:bank)
    expect(oystercard.journey).to eq(test_journey)
  end

  it "touching in and out should create one journey" do
    oystercard.top_up(5)
    oystercard.touch_in(:kings_cross)
    oystercard.touch_out(:bank)
    expect(oystercard.history.length).to eq(1)
  end

  it "should have an empty list of journeys by default" do
    expect(oystercard.history).to be_empty
  end
end
