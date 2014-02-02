# Pair programming partner: Samantha Eng

class Board

  attr_reader :places

  WINNING_POSITIONS = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7]
  ]

  def initialize
    @places = {}
    (1..9).each { |place| @places[place] = nil }
  end

  def place_mark(position, mark)
    @places[position] = mark
  end

  def empty?(position)
    @places[position].nil?
  end

  def empty_places
    @places.select { |position, _| empty?(position) }
  end

  def winner(player1, player2)
    player1_positions = @places.select { |_, mark| mark == player1.mark }
    player2_positions = @places.select { |_, mark| mark == player2.mark }
    return player1 if winning_positions?(player1_positions)
    return player2 if winning_positions?(player2_positions)
    nil
  end

  def won?(player1, player2)
    !winner(player1, player2).nil?
  end

  def winning_move?(mark, position)
    mark_positions = @places.select { |place| place == mark }
    mark_positions[position] = mark
    winning_positions?(mark_positions)
  end

  def winning_positions?(positions)
    WINNING_POSITIONS.each do |winning_positions|
      return true if winning_positions & positions.keys == winning_positions
    end
    false
  end

  def draw?
    @places.values.none? { |mark| mark.nil? }
  end
end
