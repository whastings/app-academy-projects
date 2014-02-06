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
      @position = target_position
      true
    end

    def perform_jump(position)

    end

    def make_king
      @is_king = true
    end

    private

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
  end

end

