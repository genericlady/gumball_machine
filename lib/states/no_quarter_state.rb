class NoQuarterState < State
  def insert_quarter
    puts "You have inserted a quarter"
    gumball_machine.state = gumball_machine.has_quarter
  end

  def eject_quarter
    puts "You have not inserted a quarter"
  end

  def turn_crank
    puts "You turned but there's no quarter."
  end

  def dispense
    puts "You need to pay first."
  end

end
