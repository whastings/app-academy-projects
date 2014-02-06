module Checkers

  class Piece
    attr_reader :position, :color

    def initialize(position, color, board)
      @position, @color, @board = position, color, board
    end
  end

end

