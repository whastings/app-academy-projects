class HumanPlayer < Player

  def initialize(input)
    super(input)
  end

  # Checking:

  def pick_secret_word
    secret_word = @input.get(:secret_word)
    @input.word = secret_word
    secret_word.length
  end

  def check_guess(guess)
    answer = @input.get(:guess_verification, guess)
    return nil if answer.length == 0
    answer = answer.split(',')
    answer.map do |placement|
      placement.to_i - 1
    end
  end

  # Guessing:

  def guess
    @current_guess = @input.get(:guess)
    @current_guess
  end

end
