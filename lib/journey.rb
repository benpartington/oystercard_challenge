require_relative './station.rb'

class Journey

  PENALTY_CHARGE = 6

    def initialize 
      @entry_station = nil
      @exit_station = nil
      @journey = {}

    end

    def start(entry_station)
      @entry_station = entry_station
      journey[:entry_station] = @entry_station
    end

    def finish
      @exit_station = exit_station
      journey[:exit_station] = exit_station
      @entry_station = nil
    end

    def fare
      if complete?
        Osytercard::MIN
      else
        PENALTY_CHARGE
      end
    end

      private
      
    def complete?
      (@entry_station && exit_station) != nil
    end

end

# things we need for a journey that were in oystercard.rb
#
#  journey complete???
# def in_journey?
#   @entry_station != nil
# end

# journey start???
# @entry_station = entry_station
# journey[:entry_station] = @entry_station

# journey finsih???
# journey[:exit_station] = exit_station
# @entry_station = nil

# journey fare???
# if journey complete 
# deduct(Minimum)
# else
# deduct(PENALTY_FARE)