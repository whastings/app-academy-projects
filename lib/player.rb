class Player
  attr_accessor :hand, :name, :pot

  def initialize(name, hand, pot)
    @name, @hand, @pot = name, hand, pot
  end

  def discard_cards
    cards_selected = get_user_input.scan(/\d/)
    cards_selected.map!(&:to_i)
    cards_selected = cards_selected.sort.reverse
    unless cards_selected.all? { |index| (1..5).cover?(index) }
      raise ArgumentError, "You selected invalid cards."
    end
    cards_selected.each { |index| @hand.contents.delete_at(index - 1) }
  end

end