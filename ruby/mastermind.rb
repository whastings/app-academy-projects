# Pair programming partner: Kiran Surdhar

class Mastermind

  attr_accessor :code

  COLORS = [:red, :green, :blue, :yellow, :orange, :purple]
  MAX_TURNS = 10

  def initialize
    @turns = 0
    @code = COLORS.sample(4)
  end

  def turn(guess)
    @last_guess = guess
    @turns += 1
    matches(guess)
  end

  def matches(guess)
    exact_matches, near_matches = 0, 0
    guess.each_with_index do |color, index|
      if @code.index(color) == index
        exact_matches += 1
      elsif @code.include?(color)
        near_matches += 1
      end
    end
    [exact_matches, near_matches]
  end

  def won?
    @last_guess == @code
  end

  def lost?
    @turns == MAX_TURNS && !won?
  end

  def guesses_remaining
    MAX_TURNS - @turns
  end

end

class MastermindInput

  def initialize(game)
    @game = game
  end

  def run
    puts "Enter your first sequence, separated by commas."
    puts "Choose from: red, green, blue, yellow, orange, purple"
    get_input
    puts "You won!" if @game.won?
    if @game.lost?
      puts "You lost!"
      puts "Correct answer was #{@game.code}"
    end
  end

  def get_input
    while true
      guess = gets.chomp.split(/,\s*/).map(&:to_sym)
      exact_matches, near_matches = @game.turn(guess)
      puts "You have #{exact_matches} exact matches and #{near_matches} near matches."
      break if @game.won? || @game.lost?
      puts "You have #{@game.guesses_remaining} guesses remaining. Enter your next guess."
      puts
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  new_game = Mastermind.new
  new_input = MastermindInput.new(new_game)
  new_input.run
end

