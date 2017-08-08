class NoQuarterState < State
  def insert_quarter
    puts "You have inserted a quarter"
    gumball_machine.state = gumball_machine.has_quarter
  end
end
