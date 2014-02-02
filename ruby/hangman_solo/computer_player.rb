class ComputerPlayer < Player

  def initialize(input, guesser, chooser = nil)
    super(input)
    @guesser = guesser
    @chooser = chooser
  end

  # Checking:

  def pick_secret_word
    raise "No chooser set." if @chooser.nil?
    @secret_word = @chooser.random_word
    @secret_word.length
  end

  def check_guess(guess)
    positions = []
    to_check = @secret_word.dup
    while spot = to_check.index(guess)
      positions << spot
      to_check[0..spot] = ""
    end
    positions.empty? ? nil : positions
  end

  # Guessing:

  def guess
    @current_guess = @guesser.guess(@word)
    @current_guess
  end

  def handle_guess_response(response)
    @guesser.result = response
    super(response)
  end

end
