require './chess.rb'

k = Knight.new([0, 0], nil, nil)
puts "Knight moves: #{k.moves}"

king = King.new([0, 0], nil, nil)
puts "King moves: #{king.moves}"

b = Bishop.new([0, 0], nil, nil)
puts "Bishop moves: #{b.moves}"

r = Rook.new([0, 0], nil, nil)
puts "Rook moves: #{r.moves}"

q = Queen.new([0, 0], nil, nil)
puts "Queen moves: #{q.moves}"
