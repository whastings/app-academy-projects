# Pair programming partner: Kiran Surdhar

class Game

  # TODO: Add MAX_WRONG_TURNS to replace 6's.

  def initialize(choosing_player, guessing_player)
    @choosing_player, @guessing_player = choosing_player, guessing_player
    @turns = 0
  end

  def won?
    return nil if @choosing_player.status.empty?
    @choosing_player.status.none? { |position| position == "_" }
  end

  def lost?
    @turns == 6
  end

  def play
    @guessing_player.recieve_secret_length(@choosing_player.pick_secret_word)
    # TODO: Break into #input method:
    while true
      answer = @choosing_player.check_guess(@guessing_player.guess)
      @guessing_player.handle_guess_response(answer)
      @choosing_player.visualize
      if answer.empty?
        @turns += 1
        puts "You have #{6 - @turns} guesses remaining."
      end
      break if won? || lost?
    end
    puts "#{@guessing_player} won!" if won?
    puts "#{@choosing_player} won!" if lost?
    puts @choosing_player.shake_hands
  end
end

