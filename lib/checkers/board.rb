require "piece"

module Checkers

  class Board
    def initialize
      @rows = Array.new(8) { Array.new(8) }
      fill((0..2), :white)
      fill((5..7), :black)
    end

    def [](position)
      x, y = position
      @rows[y][x]
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

  end

end
