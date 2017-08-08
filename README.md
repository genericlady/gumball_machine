# State Pattern by example
This is a small example of the state pattern using the notion
of a gumball machine. This is from the book Head First Design
Patterns, Chapter 10.

## Details
This pattern will enforce a pattern which is ideal for dealing
with a mutable state where a number of things can happen and
the behavior of our app should change at runtime without crashing.

## States
This pattern has an collection of constants that represents various possible
states. Each constant points to an integer value which represents state.

```ruby
STATES = {
  SOLD_OUT: 0,
  NO_QUARTER: 1,
  HAS_QUARTER: 2,
  SOLD: 3
}

state = STATES[:SOLD_OUT]
```

## Actions
When the user interacts with our gumball machine they are now taking an
action of inserting a quarter. Let's name it `insert_quarter` to reflect
the intent of this action and define some behavior for our new method.
Depending on what our current state is will affect the behavior that gets
returned.

```ruby
def insert_quarter(state)
  if state == STATES[:HAS_QUARTER]
    puts "You cannot insert another quarter."
  elsif state == STATES[:NO_QUARTER]
    state = STATES[:HAS_QUARTER]
    puts "You inserted a quarter."
  elsif state == STATES[:SOLD_OUT]
    puts "You can't insert a quarter the machine is sold out."
  elsif state == STATES[:SOLD]
    puts "Please wait, we're already getting you a gumball."
  end
end
```

## Abstracting everything into a class
Lets set up a namespace for all this behavior and state. Let's use a
GumballMachine class for this inside of ./lib.

```ruby
class GumballMachine
    STATES = {
     SOLD_OUT: 0,
     NO_QUARTER: 1,
     HAS_QUARTER: 2,
     SOLD: 3
  }

  attr_accessor :state, :count

  def initialize(count=0)
    @count = count
    if count > 0
      @state = STATES[:NO_QUARTER]
    end
  end

  def insert_quarter
    if state == STATES[:HAS_QUARTER]
      puts "You cannot insert another quarter."
    elsif state == STATES[:NO_QUARTER]
      state = STATES[:HAS_QUARTER]
      puts "You inserted a quarter."
    elsif state == STATES[:SOLD_OUT]
      puts "You can't insert a quarter the machine is sold out."
    elsif state == STATES[:SOLD]
      puts "Please wait, we're already getting you a gumball."
    end
  end

  def eject_quarter
    if state == STATES[:HAS_QUARTER]
      puts "Quarter returned."
      state = STATES[:NO_QUARTER]
    elsif state == STATES[:NO_QUARTER]
      puts "You haven't inserted a quarter."
    elsif state == STATES[:SOLD_OUT]
      puts "Sorry, you can't eject because you haven't inserted a quarter yet."
    elsif state == STATES[:SOLD]
      puts "Please wait, we're already getting you a gumball."
    end
  end

  def turn_crank
    if state == STATES[:HAS_QUARTER]
      puts "You turned.."
      state = STATES[:SOLD]
      dispense
    elsif state == STATES[:NO_QUARTER]
      puts "You turned but there's no quarter."
    elsif state == STATES[:SOLD_OUT]
      puts "You turned but there are no Gumballs."
    elsif state == STATES[:SOLD]
      puts "Turning twice doesn't get you more gumballs!"
    end
  end

  def dispense
    if state == STATES[:HAS_QUARTER]
      puts "Has quarter should never be the current state when dispensing."
    elsif state == STATES[:NO_QUARTER]
      puts "You need to pay first."
    elsif state == STATES[:SOLD_OUT]
      puts "Sold out should never be the current state when dispensing."
    elsif state == STATES[:SOLD]
      count = count - 1
      if count == 0
        puts "Whoops, out of gumballs"
        state = STATES[:SOLD_OUT]
      else
        state = STATES[:NO_QUARTER]
      end
      puts "A gumball comes rolling out of the slot."
    end
  end

  def to_string
  end

  def refill
    count = 10
  end
end

```

# Abstraction that leverages the Strategy Pattern

By now we are seeing a use of logic that is being repeated across our
methods. Why not abstract these different pieces of logic that depend
on our current state to make our code more DRY?

```ruby
class State
  attr_accessor :gumball_machine

  def initialize(gumball_machine)
    @gumball_machine = gumball_machine
  end

  def insert_quarter
    puts NoMethodError, "define insert_quarter"
  end

  def eject_quarter
    puts NoMethodError, "define eject_quarter"
  end

  def turn_crank
    puts NoMethodError, "define turn_crank"
  end

  def dispense
    puts NoMethodError, "define dispense"
  end

end

class SoldState < State
  def insert_quarter
  end

  def eject_quarter
  end

  def turn_crank
  end

  def dispense
  end
end

class SoldOutState < State
  def insert_quarter
  end

  def eject_quarter
  end

  def turn_crank
  end

  def dispense
  end
end

class NoQuarterState < State
  def insert_quarter
  end

  def eject_quarter
  end

  def turn_crank
  end

  def dispense
  end
end

class HasQuarterState < State
  def insert_quarter
  end

  def eject_quarter
  end

  def turn_crank
  end

  def dispense
  end
end

```

## Update GumballMachine with our new state objects.

```ruby
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

  def releaseBall
    puts "A ball comes rolling out..."
    if count != 0
      count = count - 1
    end
  end
end
```

## Implement the HasQuarter and Sold State classes.

```ruby
class HasQuarter < State
  def insert_quarter
    puts "You can't insert another quarter."
  end

  def eject_quarter
    puts "Quarter returned"
    gumball_machine.state = gumball_machine.no_quarter
  end

  def turn_crank
    puts "You turned..."
    gumball_machine.state = gumball_machine.sold_state
  end

  def dispense
    puts "No gumball dispensed."
  end
end

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
    gumball_machine.release_ball
    if gumball_machine.count > 0
      gumball_machine.state = gumball_machine.no_quarter_state
    else
      gumball_machine.state = gumball_machine.sold_out_state
    end
  end

end

```

# Run our code

```ruby
class GumballMachine
  def self.run
    gumball_machine = GumballMachine.new

    puts gumball_machine.to_s
    
    gumball_machine.insert_quarter
    gumball_machine.turn_crank

    puts gumball_machine.to_s

    gumball_machine.insert_quarter
    gumball_machine.turn_crank
    gumball_machine.insert_quarter
    gumball_machine.turn_crank

    puts gumball_machine.to_s
  end
end
```
