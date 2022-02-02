class Oystercard
    attr_reader :balance
    attr_reader :in_journey

    LIMIT = 90

    def initialize
      @balance = 0
    end
    
    def top_up(amount)
      raise "balance exceeded limit of #{LIMIT}" if (amount + balance) > LIMIT
      @balance += amount
    end

    def deduct(amount)
      @balance -= amount 
    end

    def in_journey?
      @in_journey
    end

    def touch_in
      @in_journey = true
    end

    def touch_out
      @in_journey = false
    end
end
