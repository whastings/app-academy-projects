require './chess.rb'

board = Board.new

# k = Knight.new([0, 0], nil, nil)
# puts "Knight #{k} moves: #{k.moves}"
#
# king = King.new([0, 0], nil, nil)
# puts "King #{king} moves: #{king.moves}"
#
# b = Bishop.new([0, 0], nil, nil)
# puts "Bishop #{b} moves: #{b.moves}"
#
# r = Rook.new([0, 0], nil, nil)
# puts "Rook #{r} moves: #{r.moves}"
#
q = Queen.new([0, 0], board, nil)
puts "Queen #{q} moves: #{q.moves}"
#
# p = Pawn.new([0, 0], nil, nil)
# puts "Pawn #{p} moves: #{p.moves}"

#p board.setup_board


# board.board[1].map! { |n| nil }
# p board
# p board.board[0][0].move([0, 4])

# board.board[1].map! { |n| nil }
# p board.board[0][0].move([4, 0])
p board.move([3, 0], [3, 5])
p board


## test queen movements
# board = Board.new
# q = Queen.new([0, 0], board, nil)
# puts "Queen #{q} moves: #{q.moves}"
# p board.move([3, 0], [3, 5])
# p board