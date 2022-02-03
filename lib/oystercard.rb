class Oystercard
    attr_reader :balance
    attr_reader :in_journey
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
      @in_journey
    end

    def touch_in(entry_station)
      @entry_station = entry_station
      raise "insufficient funds, balance less than #{MIN}" if balance < MIN
      @in_journey = true
    end

    def touch_out
      @in_journey = false
      deduct(MIN) 
    end

    private

    def deduct(amount)
      @balance -= amount 
    end
end
