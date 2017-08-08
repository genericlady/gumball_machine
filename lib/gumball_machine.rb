require_relative "../config/environment.rb"

class GumballMachine
  attr_accessor :state, :count, :sold_out, :no_quarter, :has_quarter, :sold

  def initialize(count=0)
    @sold_out = SoldOutState.new(self)
    @no_quarter = NoQuarterState.new(self)
    @has_quarter = HasQuarterState.new(self)
    @sold = SoldState.new(self)
    @state = @sold_out

    if count > 0
      @state = @no_quarter
    end

    @count = count
  end

  def insert_quarter
    state.insert_quarter
  end

  def eject_quarter
    state.eject_quarter
  end

  def turn_crank
    state.turn_crank
  end

  def dispense
    state.dispense
  end

  def to_s
  end

  def refill
    count = 10
  end

end
