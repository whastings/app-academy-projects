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
      STDIN.gets.chomp.scan(/\d,\d/).first.split(",").map(&:to_i)
    end

  end

end
