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
