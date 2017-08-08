class SoldOutState < State
  def insert_quarter
    puts "Hey there are no more gumballs"
  end

  def eject_quarter
    puts "Sorry, you can't eject because you haven't inserted a quarter yet."
  end

  def turn_crank
    puts "You turned but there are no Gumballs."
  end

  def dispense
    puts "Sold out should never be the current state when dispensing."
  end

end
