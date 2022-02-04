require_relative './station.rb'

class Oystercard
    attr_reader :balance, :history
    attr_accessor :journey

    LIMIT = 90
    MIN = 1

    def initialize
      @balance = 0
      @journey = nil
      @history = []
    end
    
    def top_up(amount)
      raise "balance exceeded limit of #{LIMIT}" if (amount + balance) > LIMIT
      @balance += amount
    end

    def in_journey?
      @journey != nil
    end

    def touch_in(entry_station)
      raise "insufficient funds, balance less than #{MIN}" if balance < MIN
      @journey = Journey.new
      @journey.start(entry_station)
    end

    def touch_out(exit_station)
      @journey.finish(exit_station)
      history << @journey
      deduct(@journey.fare) 
      @journey = nil
    end

    private

    def deduct(amount)
      @balance -= amount 
    end
end
