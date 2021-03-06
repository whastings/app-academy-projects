require "piece"

module Checkers

  class Board
    def initialize(should_fill = true)
      @rows = Array.new(8) { Array.new(8) }
      if should_fill
        fill((0..2), :white)
        fill((5..7), :black)
      end
    end

    def [](x, y)
      @rows[y][x]
    end

    def []=(x, y, piece)
      @rows[y][x] = piece
    end

    def move(start_pos, moves)
      piece = self[*start_pos]
      raise ArgumentError, "Piece to move doesn't exist." if piece.nil?
      if moves.count == 1
        end_pos = moves.first
        unless piece.perform_slide(end_pos) || piece.perform_jump(end_pos)
          raise ArgumentError, "The selected piece can't move there."
        end
      else
        unless piece.perform_moves(moves)
          raise ArgumentError, "Selected moves are invalid"
        end
      end
      maybe_promote(piece)
      true
    end

    def color_pieces(color)
      [].tap do |pieces_found|
        @rows.flatten.compact.each do |piece|
          pieces_found << piece if piece.color == color
        end
      end
    end

    def render
      render_string = "   0 1 2 3 4 5 6 7\n"
      @rows.each_with_index do |row, row_index|
        render_string << "#{row_index} "
        row.each do |position|
          if position.nil?
            render_string << " _"
          elsif position.color == :black
            render_string << " X"
          else
            render_string << " O"
          end
        end
        render_string << "\n"
      end
      render_string
    end

    def dup
      new_board = self.class.new(false)
      @rows.each do |row|
        row.compact.each do |piece|
          new_piece = Piece.new(piece.position.dup, piece.color, new_board)
          new_piece.make_king if piece.is_king
          new_board[*piece.position] = new_piece
        end
      end
      new_board
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
      elsif piece.color == :black && piece.pos_y == 0
        piece.make_king
      end
    end

  end

end
