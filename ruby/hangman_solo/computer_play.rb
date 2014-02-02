#!/usr/bin/env ruby

current_directory = File.dirname(__FILE__)
$LOAD_PATH << current_directory

require 'game'
require 'player'
require 'human_player'
require 'dictionary_guesser'
require 'computer_player'
require 'cli_input'

dictionary = File.readlines("#{current_directory}/dictionary.txt")
dictionary.map! { |word| word.chomp }

input = CliInput.new
dictionary_guesser = DictionaryGuesser.new(dictionary)
checking_player = HumanPlayer.new(input)
guessing_player = ComputerPlayer.new(input, dictionary_guesser)
game = Game.new(guessing_player, checking_player)

game.after_turn do |progress, wrong_guesses|
  progress.each do |char|
    if char.nil?
      print '_'
    else
      print char
    end
  end
  puts
  puts "Wrong guesses: #{wrong_guesses}"
  puts
end

if game.play
  puts 'Game won!'
else
  puts 'Game lost...'
end
