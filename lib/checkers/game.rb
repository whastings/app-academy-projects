require "board"
require "human_player"

module Checkers

  class Game
    attr_accessor :board

    def initialize
      @board = Board.new
      @players = {
        white: HumanPlayer.new,
        black: HumanPlayer.new
      }
      @current_player = :white
    end

    def play
      until won? || draw?
        puts @board.render
        puts "It's #{@current_player}'s turn"
        @board.move(*@players[@current_player].play_turn)
        @current_player = (@current_player == :white ? :black : :white )
      end
      if won?
        puts "And the winner is: #{self.winner}"
      else
        puts "Game was a draw..."
      end
    end

    def player_lost?(color)
      pieces = @board.color_pieces(color)
      return true if pieces.empty?
      return true if pieces.none? { |piece| piece.can_move? }
      false
    end

    def won?
      @players.keys.count { |color| player_lost?(color) } == 1
    end

    def draw?
      @players.keys.all? { |color| player_lost?(color) }
    end

    def winner
      return nil unless won?
      @players.keys.find { |color| !player_lost?(color) }
    end
  end


end
