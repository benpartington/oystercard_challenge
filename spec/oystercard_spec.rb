require_relative '../lib/oystercard.rb'

describe Oystercard do
  subject(:oystercard) { described_class.new }
    
    it 'card has default balance of 0' do
      expect(oystercard.balance).to eq(0)
    end
  
  # describe "#top_up" do  
  #   it "should add money to the oyster card" do
  #     oystercard = Oystercard.new
  #     expect(oystercard).to respond_to(:top_up).with(1).argument
  #   end
  # end
end



