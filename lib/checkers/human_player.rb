module Checkers

  class HumanPlayer

    def play_turn
      puts "Piece to move (x,y):"
      start_pos = get_input
      moves = []
      loop do
        puts "Position to move to next (x,y)"
        puts "Or leave empty to stop selecting moves:"
        next_move = get_input
        break if next_move.nil?
        moves << next_move
      end
      raise ArgumentError, "No move selected." if moves.empty?
      [start_pos, moves]
    end

    def get_input
      input = STDIN.gets.chomp
      input = input.scan(/\d/)
      return nil if input.empty?
      unless input.count == 2 && input.all? { |num| (0..7).cover?(num.to_i) }
        raise ArgumentError, "Position entered was invalid"
      end
      input.map(&:to_i)
    end

  end

end
