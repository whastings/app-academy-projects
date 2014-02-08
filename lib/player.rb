class Player
  attr_accessor :hand, :name, :pot

  def initialize(name, pot)
    @name, @hand, @pot = name, nil, pot
  end

  def discard_cards
    cards_selected = get_user_input.scan(/\d/)
    cards_selected.map!(&:to_i)
    cards_selected = cards_selected.sort.reverse
    unless cards_selected.all? { |index| (1..5).cover?(index) }
      raise ArgumentError, "You selected invalid cards."
    end
    cards_selected.each { |index| @hand.contents.delete_at(index - 1) }
    return cards_selected.count
  end

  def place_bet(highest_bet)
    choice = get_user_input
    case choice
    when 'r'
      amount_to_raise = get_user_input.to_i
      if amount_to_raise > @pot || amount_to_raise < highest_bet
        raise ArgumentError
      end
      @pot -= amount_to_raise
      amount_to_raise
    when 's'
      if highest_bet > @pot
        raise ArgumentError, "You don't have enough in your pot to see."
      end
      @pot -= highest_bet
      highest_bet
    when 'f'
      -1
    end
  end

  def add_cards(cards)
    @hand.contents.concat(cards)
  end

end
