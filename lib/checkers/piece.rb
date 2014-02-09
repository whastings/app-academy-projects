require "invalid_move_error"

module Checkers

  class Piece
    attr_accessor :position
    attr_reader :color

    WHITE_DIRECTIONS = [[1, 1], [-1, 1]]
    BLACK_DIRECTIONS = [[1, -1], [-1, -1]]

    def initialize(position, color, board)
      @position, @color, @board = position, color, board
      @is_king = false
    end

    def pos_x
      @position.first
    end

    def pos_y
      @position.last
    end

    def perform_slide(target_position)
      return false unless @board[*target_position].nil?
      return false unless possible_moves.include?(target_position)
      update_board(target_position)
      @position = target_position
      true
    end

    def perform_jump(target_position)
      return false unless possible_jumps.include?(target_position)
      jumped_position = jumped_piece(target_position)
      return false if @board[*jumped_position].color == @color
      @board[*jumped_position] = nil
      update_board(target_position)
      @position = target_position
      true
    end

    def perform_moves(sequence)
      raise InvalidMoveError unless valid_move_seq?(sequence)
      perform_moves!(sequence)
    end

    def valid_move_seq?(sequence)
      duped_board = @board.dup
      valid = true
      begin
        duped_board[*@position].perform_moves!(sequence)
      rescue InvalidMoveError
        valid = false
      end
      valid
    end

    def perform_moves!(sequence)
      sequence.each do |move|
        result = true
        if sequence.count == 1
          result = perform_slide(move) || perform_jump(move)
        else
          result = perform_jump(move)
        end
        raise InvalidMoveError unless result
      end
    end

    def make_king
      @is_king = true
    end

    private

    def update_board(target_position)
      @board[*target_position] = self
      @board[*@position] = nil
    end

    def possible_moves
      directions.map do |dir_x, dir_y|
        [dir_x + pos_x, dir_y + pos_y]
      end
    end

    def directions
      base_directions = BLACK_DIRECTIONS
      if @color == :white
        base_directions = WHITE_DIRECTIONS
      end
      return base_directions unless @is_king
      base_directions + base_directions.map { |x, y| [x * -1, y * -1] }
    end

    def possible_jumps
      possibilities = []
      possible_moves.each do |move_x, move_y|
        next if @board[move_x, move_y].nil?
        diff_x, diff_y = move_x - pos_x, move_y - pos_y
        jump_position = [move_x + diff_x, move_y + diff_y]
        possibilities << jump_position if @board[*jump_position].nil?
      end
      possibilities
    end

    def jumped_piece(target_position)
      x, y = target_position
      diff_x, diff_y = x + pos_x, y + pos_y
      [diff_x / 2, diff_y / 2]
    end
  end

end

