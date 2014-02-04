# encoding: utf-8
# Pair programming partner: Weyman Fung

require 'yaml'
require './minesweeper'

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new(ARGV.shift)
  game.play
end
