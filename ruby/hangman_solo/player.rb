class Player

  def initialize(input)
    @input = input
    @guessed_letters = []
  end

  def receive_secret_length(length)
    @secret_length = length
    @word = []
    length.times { @word << nil }
  end

  # Returns true if solved, false otherwise.
  def handle_guess_response(response)
    if response
      mark_right_guess(response, @current_guess)
      return true if @word.all?
    else
      mark_wrong_guess(@current_guess)
    end
    false
  end

  def progress
    @word
  end

  private

    def mark_wrong_guess(guess)
      @wrong_guesses ||= 0
      @wrong_guesses += 1
    end

    def mark_right_guess(places, guess)
      places.each { |place| @word[place] = guess }
    end

end
