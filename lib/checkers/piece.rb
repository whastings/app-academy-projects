module Checkers

  class Piece
    attr_accessor :position
    attr_reader :color

    WHITE_DIRECTIONS = [[1, 1], [-1, 1]]
    BLACK_DIRECTIONS = [[1, -1], [-1, -1]]

    def initialize(position, color, board)
      @position, @color, @board = position, color, board
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

    private

    def possible_moves
      directions.map do |dir_x, dir_y|
        [dir_x + pos_x, dir_y + pos_y]
      end
    end

    def directions
      return WHITE_DIRECTIONS if @color == :white
      BLACK_DIRECTIONS
    end
  end

end

