require_relative './station.rb'

class Oystercard
    attr_reader :balance, :entry_station, :history
    attr_accessor :journey

    LIMIT = 90
    MIN = 1

    def initialize
      @balance = 0
      @journey = {}
      @history = []
    end
    
    def top_up(amount)
      raise "balance exceeded limit of #{LIMIT}" if (amount + balance) > LIMIT
      @balance += amount
    end

    def in_journey?
      @entry_station != nil
    end

    def touch_in(entry_station)
      raise "insufficient funds, balance less than #{MIN}" if balance < MIN
      @entry_station = entry_station
      journey[:entry_station] = @entry_station
    end

    def touch_out(exit_station)
      journey[:exit_station] = exit_station
      history << journey
      deduct(MIN) 
      @entry_station = nil
    end

    private

    def deduct(amount)
      @balance -= amount 
    end
end
