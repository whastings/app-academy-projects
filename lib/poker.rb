
$LOAD_PATH << File.dirname(__FILE__)

require 'deck'
require 'player'

class Poker
  attr_accessor :pot, :players

  def initialize(players)
    @players = players
    @deck = Deck.new
    @deck.shuffle
    @pot = 0
  end

  def deal_cards
    @players.each do |player|
      player.add_cards(@deck.draw(5))
    end
  end

  def take_bets
    highest_bet, players_to_remove = 1, []
    @players.each do |player|
      begin
        player_bet = player.place_bet(highest_bet)
      rescue ArgumentError => error
        puts error.message
        retry
      end
      if player_bet == -1
        players_to_remove << player
        next
      end
      @pot += player_bet
      highest_bet = player_bet if player_bet > highest_bet
    end
    @players.delete_if { |player| players_to_remove.include?(player) }
  end

  def play_draw
    @players.each do |player|
      begin
        num_cards = player.discard_cards
      rescue ArgumentError => error
        puts error.message
        retry
      end
      player.add_cards(@deck.draw(num_cards)) if num_cards > 0
    end
  end

  def determine_winner
    winners = []
    winners << @players.max do |player1, player2|
      player1.score <=> player2.score
    end
    winners.concat(@players.select do |player|
      player.score == winners.first.score && player != winners.first
    end )
    winners
  end

  def play
    deal_cards
    take_bets
    play_draw
    take_bets
    winners = determine_winner
    if winners.count == 1
      puts "And the winner is: #{winners.first.name}"
    else
      winners_names = winners.map { |winner| winner.name }.join(", ")
      puts "And the winners are: #{winners_names}"
    end
  end

end

if __FILE__ == $PROGRAM_NAME
  player1 = Player.new("Player 1", 5)
  player2 = Player.new("Player 2", 5)
  game = Poker.new([player1, player2])
  game.play
end
