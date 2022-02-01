class Oystercard
    attr_reader :balance
    
    LIMIT = 90

    def initialize
      @balance = 0
    end
    
    def topup(amount)
      raise "balance exceeded limit of #{LIMIT}" if (amount + balance) > LIMIT
      @balance += amount
    end

end
