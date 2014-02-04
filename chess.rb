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

class SlidingPiece < Piece
  ORTHAGONAL = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  DIAGONAL = [[1, 1], [1, -1], [-1, 1], [-1, -1]]

  def moves
    x, y = @position
    possible_moves = []
    (1..7).each do |multiplier|
      move_dirs.each do |x_offset, y_offset|
        new_x, new_y = x + (multiplier * x_offset), y + (multiplier * y_offset)
        if ((0..7).cover?(new_x) && (0..7).cover?(new_y))
          possible_moves << [new_x, new_y]
        end
      end
    end
    possible_moves
  end

end


class Bishop < SlidingPiece
  def move_dirs
    DIAGONAL
  end
end

class Rook < SlidingPiece
  def move_dirs
    ORTHAGONAL
  end
end

class Queen < SlidingPiece
  def move_dirs
    DIAGONAL + ORTHAGONAL
  end
end

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

