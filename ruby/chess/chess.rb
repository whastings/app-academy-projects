
require 'colorize'
require './pieces/piece'
require './pieces/sliding_piece'
require './pieces/stepping_piece'
require './pieces/rook.rb'
require './pieces/knight.rb'
require './pieces/bishop.rb'
require './pieces/queen.rb'
require './pieces/king.rb'
require './pieces/pawn.rb'

require './board'
require './game'
require './human_player'

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  game.play
end
