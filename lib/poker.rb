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
    highest_bet, players_to_remove = 0, []
    @players.each do |player|
      player_bet = player.place_bet(highest_bet)
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
      num_cards = player.discard_cards
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

end
