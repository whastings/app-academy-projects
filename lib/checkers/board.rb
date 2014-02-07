require "piece"

module Checkers

  class Board
    def initialize
      @rows = Array.new(8) { Array.new(8) }
      fill((0..2), :white)
      fill((5..7), :black)
    end

    def [](x, y)
      @rows[y][x]
    end

    def []=(x, y, piece)
      @rows[y][x] = piece
    end

    def move(start_pos, end_pos)
      piece = self[*start_pos]
      raise ArgumentError, "Piece to move doesn't exist." if piece.nil?
      if piece.perform_slide(end_pos) || piece.perform_jump(end_pos)
        self[*start_pos] = nil
        self[*end_pos] = piece
        maybe_promote(piece)
        true
      else
        raise ArgumentError, "The selected piece can't move there."
      end
    end

    def render
      render_string = ""
      @rows.each do |row|
        row.each do |position|
          if position.nil?
            render_string << "_"
          elsif position.color == :black
            render_string << "X"
          else
            render_string << "O"
          end
        end
        render_string << "\n"
      end
      render_string
    end

    private

    def fill(range, color)
      range.each do |row_index|
        if row_index.even?
          fill_even(row_index, color)
        else
          fill_odd(row_index, color)
        end
      end
    end

    def fill_odd(row_index, color)
      (0..7).each do |col_index|
        next if col_index.even?
        @rows[row_index][col_index] =
          Piece.new([col_index, row_index], color, self)
      end
    end

    def fill_even(row_index, color)
      (0..7).each do |col_index|
        next if col_index.odd?
        @rows[row_index][col_index] =
          Piece.new([col_index, row_index], color, self)
      end
    end

    def maybe_promote(piece)
      if piece.color == :white && piece.pos_y == 7
        piece.make_king
      elsif piece.color == :black && piece.pos_y = 0
        piece.make_king
      end
    end

  end

end
