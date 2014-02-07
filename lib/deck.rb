require 'card'

class Deck
  include Enumerable

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

  private

  def setup
    (1..13).flat_map do |num|
      [:h, :d, :s, :c].map { |suit| Card.new(num, suit) }
    end
  end

end