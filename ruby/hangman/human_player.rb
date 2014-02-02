# Pair programming partner: Kiran Surdhar

class HumanPlayer < Player
  def initialize
    super
  end

  def guess
    puts "Guess a letter:"
    input = gets.chomp
    unless ("a".."z").include?(input)
      puts "Incorrect input. Please retry."
      guess
    end
    input
  end

  def pick_secret_word
    puts "Enter the length of the secret word."
    @secret_word_length = gets.chomp.to_i
    recieve_secret_length(@secret_word_length)
    @secret_word_length
  end

  def check_guess(guess)
    puts "Computer guessed the letter #{guess}."
    puts "Indicate locations if any, separated by commas, or press enter for none."
    input = gets.chomp
    if input.empty?
      input = []
    else
      input = input.split(/,\s*/).map { |character| character.to_i - 1 }
    end
    update_status(guess, input)
    input
  end

  def shake_hands
    "Good game."
  end

  def to_s
    "You"
  end

end
