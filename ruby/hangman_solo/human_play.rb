#!/usr/bin/env ruby

current_directory = File.dirname(__FILE__)
$LOAD_PATH << current_directory

require 'game'
require 'player'
require 'human_player'
require 'dictionary_chooser'
require 'computer_player'
require 'cli_input'

dictionary = File.readlines("#{current_directory}/dictionary.txt")
dictionary.map! { |word| word.chomp }

input = CliInput.new
guessing_player = HumanPlayer.new(input)
dictionary_chooser = DictionaryChooser.new(dictionary)
checking_player = ComputerPlayer.new(input, nil, dictionary_chooser)
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
