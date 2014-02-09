require 'hand'

class Player
  attr_accessor :hand, :name, :pot

  def initialize(name, pot)
    @name, @hand, @pot = name, Hand.new, pot
  end

  def discard_cards
    print_status
    puts "#{@name}, please select which cards (1-5) you would like to discard"
    cards_selected = get_user_input.scan(/\d/)
    cards_selected.map!(&:to_i)
    cards_selected = cards_selected.sort.reverse
    unless cards_selected.all? { |index| (1..5).cover?(index) }
      raise ArgumentError, "You selected invalid cards."
    end
    if cards_selected.count > 3
      raise ArgumentError, "You can only discard at most three cards."
    end
    cards_selected.each { |index| @hand.contents.delete_at(index - 1) }
    return cards_selected.count
  end

  def place_bet(highest_bet)
    print_status
    puts "The current bet is #{highest_bet}"
    puts "#{@name}, what you like to raise (r), see (s), or fold (f)?"
    choice = get_user_input
    case choice
    when 'r'
      raise_bet(highest_bet)
    when 's'
      see(highest_bet)
    when 'f'
      -1
    else
      raise ArgumentError, "That's an invalid choice."
    end
  end

  def add_cards(cards)
    @hand.contents.concat(cards)
  end

  def score
    @hand.score
  end

  def get_user_input
    $stdin.gets.chomp
  end

  private

  def raise_bet(highest_bet)
    puts "#{@name}, what would you like to raise to?"
    amount_to_raise = get_user_input.to_i
    if amount_to_raise > @pot || amount_to_raise < highest_bet
      raise ArgumentError, "You don't have enough in your pot to raise that."
    end
    @pot -= amount_to_raise
    amount_to_raise
  end

  def see(highest_bet)
    if highest_bet > @pot
      raise ArgumentError, "You don't have enough in your pot to see."
    end
    @pot -= highest_bet
    highest_bet
  end

  def print_status
    puts
    puts "#{@name} status:"
    puts "Pot: #{@pot}"
    puts "Hand: #{@hand}"
    puts
  end
end
