require 'colorize'

class Piece

  attr_reader :color
  attr_accessor :position

  def initialize(position, board, color)
    @position = position
    @board = board.board
    @color = color
  end

  def moves
    # filter moves out of board

  end

  def move(position)
    x, y = position
    target_position = @board[y][x]
    return true if target_position.nil?
    return false if target_position.color == @color
    true # If target_position.color is a different color.
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

  def move(position)
    return false unless super
    possible_moves = moves
    return false unless possible_moves.include?(position)

    check_moves(position, possible_moves)
  end

  def check_moves(position, possible_moves)
    x_direction, y_direction = [], []
    possible_moves.each_index do |index|
      x_direction << possible_moves[index] if index.odd?
      y_direction << possible_moves[index] if index.even?
    end

    if x_direction.include?(position)
      x_direction = x_direction.take(x_direction.index(position))
       return x_direction.all? { |x_coord, y_coord| @board[y_coord][x_coord].nil? }
    else
      y_direction = y_direction.take(y_direction.index(position))
      return y_direction.all? { |x_coord, y_coord| @board[y_coord][x_coord].nil? }
    end
  end
end


class Bishop < SlidingPiece
  def move_dirs
    DIAGONAL
  end
  def to_s
    "\u2657 "
  end

end

class Rook < SlidingPiece

  def move_dirs
    ORTHAGONAL
  end

  def to_s
    "\u2656 "
  end
end

class Queen < SlidingPiece

  def move_dirs
    DIAGONAL + ORTHAGONAL
  end

  def move(position)
    diagonals = []
    possible_moves = moves

    possible_moves.each_with_index do |move, index|
      diagonals << move if (index % 3 == 0 || index == 0)
    end
    if diagonals.include?(position)
      check_moves(position, diagonals)
    else
      orthagonal = possible_moves.reject { |move| diagonals.include?(move) }
      check_moves(position, orthagonal)
    end
  end

  def to_s
    "\u2655 "
  end
end

class Knight < SteppingPiece

  DIRECTION = [[1, 2], [1, -2], [-1, 2], [-1, -2],
  [2, 1], [2, -1], [-2, 1], [-2, -1]]

  def move_dirs
    DIRECTION
  end

  def to_s
    "\u2658 "
  end
end

class King < SteppingPiece

  DIRECTION = [[1, 1], [1, 0], [1, -1], [0, 1],
  [0, -1], [-1, 1], [-1, 0], [-1, -1]]

  def move_dirs
    DIRECTION
  end

  def to_s
    "\u2654 "
  end

end

class Pawn < Piece

  def to_s
    "\u2659 "
  end

end

class Board
  attr_reader :board

  START_POSITION = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  START_ROW = [0, 1, 6, 7]

  def initialize
    @board = Array.new(8){Array.new(8)}
    setup_board
  end

  def setup_board
    START_ROW.each do |row|
      color = row > 3 ? :w : :b
      if row == 1 || row == 6
        @board[row].each_index do |index|
          @board[row][index] = Pawn.new([index, row], self, color)
        end
      else
        @board[row].each_index do |index|
          @board[row][index] = START_POSITION[index].new([index, row], self, color)
        end
      end
    end

    @board
  end

  def move(start_pos, end_pos)
    start_x, start_y = start_pos
    end_x, end_y = end_pos
    piece = @board[start_y][start_x]
    if piece.move(end_pos)
      piece.position = end_pos
      @board[start_y][start_x] = nil
      @board[end_y][end_x] = piece
    else
      raise ArgumentError, "Can't move there asshole!"
    end
  end

end

class Game

end

class Player

end
