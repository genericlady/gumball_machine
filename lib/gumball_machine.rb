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
    puts "Gumball Machine"
    puts "inventory #{count}"
    if count > 0
      puts "Machine is ready for your quarter"
    else
      puts "Ooops no more gumballs"
    end
  end

  def refill
    count = 10
  end

  def release_ball
    puts "A ball comes rolling out."
  end

  def self.run
    gumball_machine = GumballMachine.new(5)

    puts gumball_machine.to_s
    
    gumball_machine.insert_quarter
    gumball_machine.turn_crank

    puts gumball_machine.to_s

    gumball_machine.insert_quarter
    gumball_machine.turn_crank
    gumball_machine.insert_quarter
    gumball_machine.turn_crank

    puts gumball_machine.to_s

    gumball_machine.insert_quarter
    gumball_machine.turn_crank
    puts gumball_machine.to_s

    gumball_machine.insert_quarter
    gumball_machine.turn_crank
    puts gumball_machine.to_s
  end

end
