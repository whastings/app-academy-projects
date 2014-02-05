class Pawn < Piece

  DIRECTION = [[0, 1], [0, 2], [0, -1], [0, -2]]

  def to_s
    "\u2659 "
  end

  def move_dirs
    return DIRECTION[0..1] if @color == :b
    DIRECTION[2..3]
  end

  def move(position)
    return false unless super
    moves.include?(position)
  end

  def moves
    x, y = @position
    possible_moves = []
    move_dirs.each do |x_offset, y_offset|
      new_x, new_y = x + x_offset, y + y_offset
      if ((0..7).cover?(new_x) && (0..7).cover?(new_y))
        possible_moves << [new_x, new_y] if @board[new_y][new_x].nil?
      end
    end
    possible_moves
  end

end