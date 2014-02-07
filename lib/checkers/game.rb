require "board"
require "human_player"

module Checkers

  class Game
    def initialize
      @board = Board.new
      @players = {
        white: HumanPlayer.new,
        black: HumanPlayer.new
      }
      @current_player = :white
    end

    def play
      while true
        @board.move(*@players[@current_player].play_turn)
        @current_player = (@current_player == :white ? :black : :white )
        puts @board.render
      end
    end
  end

end
