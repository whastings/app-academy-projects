class Hand

  attr_accessor :contents

  HANDS = {
    royal_flush: 9,
    straight_flush: 8,
    four_kind: 7,
    full_house: 6,
    flush: 5,
    straight: 4,
    three_kind: 3,
    two_pair: 2,
    pair: 1
  }

  def initialize(cards)
    @contents = cards
  end


  def score
    HANDS.each do |hand, points|
      if self.send("has_#{hand}?")
        return points
      end
    end
    0
  end

  def highest_card
    return 14 if get_numbers.include?(1)
    get_numbers.max
  end

  def has_pair?
    has_repeated_number?(2)
  end

  def has_three_kind?
    has_repeated_number?(3)
  end

  def has_two_pair?
    get_number_frequencies.count { |num,count| count == 2 } == 2
  end

  def has_straight?
    numbers = get_numbers
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
    has_repeated_number?(4)
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

  def get_numbers
    @contents.map { |card| card.num }
  end

  def has_repeated_number?(repeats)
    get_number_frequencies.any? { |num,count| count == repeats }
  end

end