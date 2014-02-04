class Piece

  def initialize(position, board, color)
    @position = position
    @board = board
    @color = color
  end

  def moves
    # filter moves out of board

  end

end

class SteppingPiece < Piece

  def moves
    x, y = @position
    move_dirs.map do |x_offset, y_offset|
      [x + x_offset, y + y_offset]
    end
  end

end

# class SlidingPiece < Piece
#   ORTHAGONAL = [[0, 1], [0, -1], [1, 0], [-1, 0]]
#   DIAGONAL = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
#
#
# end


# class Bishop < SlidingPiece
#
# end
#
# class Rook < SlidingPiece
#
# end
#
# class Queen < SlidingPiece
#
# end

class Knight < SteppingPiece

  DIRECTION = [[1, 2], [1, -2], [-1, 2], [-1, -2],
              [2, 1], [2, -1], [-2, 1], [-2, -1]]

  def move_dirs
    DIRECTION
  end

end

class King < SteppingPiece

  DIRECTION = [[1, 1], [1, 0], [1, -1], [0, 1],
              [0, -1], [-1, 1], [-1, 0], [-1, -1]]

  def move_dirs
    DIRECTION
  end

end

class Pawn < Piece

end

class Board

end

class Game

end

class Player

end

