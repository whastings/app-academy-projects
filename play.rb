# encoding: utf-8

require 'yaml'
require './minesweeper'

if __FILE__ == $PROGRAM_NAME
  game = Minesweeper.new(ARGV.shift)
  game.play
end
