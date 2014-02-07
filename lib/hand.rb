class Hand

  attr_accessor :contents

  HANDS = {
    high_card: 0,
    pair: 1,
    two_pairs: 2,
    three_kind: 3,
    straight: 4,
    flush: 5,
    full_house: 6,
    four_kind: 7,
    straight_flush: 8,
    royal_flush: 9
  }

  def initialize(cards)
    @contents = cards
  end

  def score

  end

  def has_pair?
    get_number_frequencies.any? { |num,count| count == 2 }
  end

  def has_three_kind?
    get_number_frequencies.any? { |num,count| count == 3 }
  end

  def has_two_pair?
    get_number_frequencies.count { |num,count| count == 2 } == 2
  end

  def has_straight?
    numbers = get_number_frequencies.keys.sort
    numbers.each_with_index do |num, index|
      next if index == numbers.length - 1
      next if num == 1 && numbers[index+1] == 10
      return false unless num + 1 == numbers[index + 1]
    end
    true
  end

  def has_flush?
    get_suits_frequencies.any? { |suit, count| count == 5 }
  end

  def has_full_house?
    get_number_frequencies.all? { |num, count| (2..3).cover?(count) }
  end

  def has_four_kind?
    get_number_frequencies.any? { |num, count| count == 4 }
  end

  def has_straight_flush?
    has_flush? && has_straight?
  end

  def has_royal_flush?
    numbers = get_number_frequencies.keys.sort
    has_flush? && numbers == [1,10,11,12,13]
  end

  private

  def get_number_frequencies
    number_frequencies = Hash.new(0)
    @contents.each do |card|
      number_frequencies[card.num] += 1
    end
    number_frequencies
  end

  def get_suits_frequencies
    suit_frequencies = Hash.new(0)
    @contents.each do |card|
      suit_frequencies[card.suit] += 1
    end
    suit_frequencies
  end

end