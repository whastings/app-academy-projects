# Pair programming partner: Samantha Eng

class Game
  def initialize(player1, player2, board)
    @player1, @player2, @board = player1, player2, board
  end

  def play
    current_player = @player1
    until @board.won?(@player1, @player2) || @board.draw?
      current_player.play(@board)
      current_player = current_player == @player1 ? @player2 : @player1
      print_board
    end
    if @board.draw?
      puts "It was a draw!"
    else
      winner = @board.winner(@player1, @player2)
      puts "Player #{winner.mark} has won."
    end
  end

  def print_board
    @board.places.each do |position, mark|
      print mark.nil? ? " " : mark
      if position % 3 == 0
        puts "\n-----" unless position > 6
      else
        print "|"
      end
    end
    puts "\n\n"
  end
end
