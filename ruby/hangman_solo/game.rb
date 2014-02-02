class Game

  MAX_WRONG_GUESSES = 6

  def initialize(guessing_player, checking_player)
    @guessing_player = guessing_player
    @checking_player = checking_player
    @wrong_guesses = 0
  end

  # Returns true if guessing player won, false if not.
  def play
    secret_word_length = @checking_player.pick_secret_word
    @guessing_player.receive_secret_length(secret_word_length)
    loop do
      guess = @guessing_player.guess
      check = @checking_player.check_guess(guess)
      @wrong_guesses += 1 unless check
      return false if @wrong_guesses == MAX_WRONG_GUESSES
      return true if @guessing_player.handle_guess_response(check)
      @after_turn.call(@guessing_player.progress, @wrong_guesses)
    end
  end

  def after_turn(&block)
    @after_turn = block
  end

end
