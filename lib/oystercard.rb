class Oystercard
    attr_reader :balance
    
    LIMIT = 90

    def initialize
      @balance = 0
    end
    
    def topup(amount)
      if ((@balance + amount) > LIMIT) ? raise_error : #something else
      @balance += amount
    end



end