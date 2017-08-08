class State
  attr_accessor :gumball_machine

  def initialize(gumball_machine)
    @gumball_machine = gumball_machine
  end

  def insert_quarter
    raise NoMethodError, "define insert_quarter"
  end

  def eject_quarter
    raise NoMethodError, "define eject_quarter"
  end

  def turn_crank
    raise NoMethodError, "define turn_crank"
  end

  def dispense
    raise NoMethodError, "define dispense"
  end

end
