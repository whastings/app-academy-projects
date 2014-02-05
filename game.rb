class Game

  attr_accessor :board

  def initialize
    @board = Board.new
    @player1, @player2 = HumanPlayer.new(@board), HumanPlayer.new(@board)
    @current_turn = @player1
  end

  def display_board
    @board.board.each do |row|
      row.each do |piece|
        print piece.nil? ? '- ' : piece
      end
      puts ''
    end
  end

  def play
    until @board.checkmate?(:w) || @board.checkmate?(:b)
      begin
        move = @current_turn.play_turn
        @board.move(move.first, move.last)
        @current_turn = @current_turn == @player1 ? @player2 : @player1
      rescue MoveError => e
        system('clear')
        puts e.message
        sleep(1)
        retry
      end
    end

    puts "Game Over! You freaking won!"
  end

end
