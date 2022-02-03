class Oystercard
    attr_reader :balance
    attr_reader :entry_station

    LIMIT = 90
    MIN = 1

    def initialize
      @balance = 0
    end
    
    def top_up(amount)
      raise "balance exceeded limit of #{LIMIT}" if (amount + balance) > LIMIT
      @balance += amount
    end

    def in_journey?
      @entry_station != nil
    end

    def touch_in(entry_station)
      @entry_station = entry_station
      raise "insufficient funds, balance less than #{MIN}" if balance < MIN
    end

    def touch_out
      deduct(MIN) 
      @entry_station = nil
    end

    private

    def deduct(amount)
      @balance -= amount 
    end
end
