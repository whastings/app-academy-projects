require './chess.rb'

k = Knight.new([0, 0], nil, nil)
puts "Knight moves: #{k.moves}"

king = King.new([0, 0], nil, nil)
puts "King moves: #{king.moves}"