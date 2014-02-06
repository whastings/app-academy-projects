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

  # Makes sure no pieces are between piece and the target position.
  def check_moves(position, possible_moves)
    increment = []
    start_pos, end_pos = @position.dup, position.dup
    # handle y movement
    if start_pos[0] == end_pos[0]
      difference = end_pos[1] - start_pos[1]
      diff = difference / difference.abs
      while end_pos != start_pos
        #list of positions before target
        increment << [start_pos[0], start_pos[1] + diff]
        start_pos[1] += diff
      end
    # handle x movement
    elsif start_pos[1] == end_pos[1]
      difference = end_pos[0] - start_pos[0]
      diff = difference / difference.abs
      while end_pos != start_pos
        #list of positions before target
        increment << [start_pos[0] + diff, start_pos[1]]
        start_pos[0] += diff
      end
    # handle diagonals
    else
      x_difference = end_pos[0] - start_pos[0]
      y_difference = end_pos[1] - start_pos[1]
      x_diff = x_difference / x_difference.abs
      y_diff = y_difference / y_difference.abs
      while end_pos != start_pos
        #list of positions before target
        increment << [start_pos[0] + x_diff, start_pos[1] + y_diff]
        start_pos[0] += x_diff
        start_pos[1] += y_diff
      end
    end
    increment.include?(position)
  end
end
