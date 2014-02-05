class SteppingPiece < Piece

  def moves
    x, y = @position
    move_dirs.map do |x_offset, y_offset|
      [x + x_offset, y + y_offset]
    end
  end

end