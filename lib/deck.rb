require 'card'

class Deck
  include Enumerable

  attr_reader :cards

  def initialize
    @cards = []
    @cards = setup
  end

  def each(&block)
    @cards.each(&block)
  end

  def length
    @cards.length
  end

  def shuffle
    @cards = @cards.shuffle
  end

  def pop
    @cards.pop
  end

  def draw(num)
    [].tap do |cards_drawn|
      num.times { cards_drawn << self.pop }
    end
  end


  private

  def setup
    (1..13).flat_map do |num|
      [:h, :d, :s, :c].map { |suit| Card.new(num, suit) }
    end
  end


end