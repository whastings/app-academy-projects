# Pair programming partner: Samantha Eng

class Player
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end
end

class HumanPlayer < Player
  def play(board)
    puts "Choose a move from 1 - 9."
    input = gets.chomp
    until input =~ /\A[1-9]\z/ && board.empty?(input.to_i)
      puts "Invalid move. Choose a move from 1 - 9."
      input = gets.chomp
    end
    board.place_mark(input.to_i, mark)
  end
end

class ComputerPlayer < Player
  def play(board)
    move = nil
    possible_moves = board.empty_places
    possible_moves.each do |possible_move|
      if board.winning_move?(mark, possible_move)
        move = possible_move
        break
      end
    end
    move = possible_moves.keys.sample if move.nil?
    board.place_mark(move, mark)
  end
end
