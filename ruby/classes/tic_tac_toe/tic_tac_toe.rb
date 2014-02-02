# Pair programming partner: Samantha Eng

require './player'
require './board'
require './game'

if __FILE__ == $PROGRAM_NAME
  human_player = HumanPlayer.new("X")
  comp_player = ComputerPlayer.new("O")
  board = Board.new
  Game.new(human_player, comp_player, board).play
end
