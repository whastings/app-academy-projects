class Card
  attr_accessor :num, :suit

  def initialize(num, suit)
    @num = num
    @suit = suit
  end

  def to_s
    "#{@num}#{@suit}"
  end

  def == other_card
    to_s == other_card.to_s
  end

end