class HasQuarterState < State
  def insert_quarter
    puts "You cannot insert another quarter."
  end

  def eject_quarter
    puts "Quarter returned."
    gumball_machine.state = gumball_machine.no_quarter
  end

  def turn_crank
    puts "You turned the crank"
    gumball_machine.state = gumball_machine.sold
    gumball_machine.dispense
  end

  def dispense
    puts "No Gumball Dispensed"
  end
end
