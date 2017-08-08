class SoldState < State
  def insert_quarter
    puts "Please wait we are already giving you a gumball."
  end

  def eject_quarter
    puts "Sorry you already turned the crank."
  end

  def turn_crank
    puts "Turning twice does nothing."
  end

  def dispense
    gumball_machine.count = gumball_machine.count - 1
    gumball_machine.release_ball
    if gumball_machine.count > 0
      gumball_machine.state = gumball_machine.no_quarter
    else
      gumball_machine.state = gumball_machine.sold_out
    end
  end

end
