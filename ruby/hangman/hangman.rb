# Pair programming partner: Kiran Surdhar

require "./player"
require "./game"
require "./computer_player"
require "./human_player"

if __FILE__ == $PROGRAM_NAME
  computer_player = ComputerPlayer.new
  computer_player.file_name = "dictionary.txt"
  user = HumanPlayer.new
  game = Game.new(user, computer_player)
  game.play
end
