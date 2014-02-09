module Checkers

  class HumanPlayer

    def play_turn
      puts "Piece to move (x,y):"
      start_pos = get_input
      puts "Position to move to (x,y):"
      end_pos = get_input
      [start_pos, end_pos]
    end

    def get_input
      input = STDIN.gets.chomp
      input = input.scan(/\d/)
      unless input.count == 2 && input.all? { |num| (0..7).cover?(num.to_i) }
        raise ArgumentError, "Position entered was invalid"
      end
      input.map(&:to_i)
    end

  end

end
