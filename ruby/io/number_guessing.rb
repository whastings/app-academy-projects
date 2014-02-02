# Pair programming partner: Samantha Eng

class NumberGame

  def initialize
    @number = choose_number
    @guesses = 0
  end

  def choose_number
    rand(100) + 1
  end

  def valid_guess?(guess)
    @guesses += 1
    guess == @number
  end

  def too_high?(guess)
    guess > @number
  end

  def too_low?(guess)
    guess < @number
  end

  def play
    puts "Please enter a guess between 0 and 100."
    guess = gets.chomp.to_i
    until valid_guess?(guess)
      puts "Too low!" if too_low?(guess)
      puts "Too high!" if too_high?(guess)
      guess = gets.chomp.to_i
    end
    puts "You guessed in #{@guesses} guesses."
  end
end

if __FILE__ == $PROGRAM_NAME
  NumberGame.new.play
end
