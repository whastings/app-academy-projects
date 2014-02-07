require 'rspec'
require 'deck'

describe Deck do

  subject(:deck) { Deck.new }
  let(:start_cards) do
    (1..13).flat_map do |num|
      ['h', 'd', 's', 'c'].map { |suit| "#{num}#{suit}" }
    end
  end

  it "should start with 52 cards" do
    expect(subject.length).to eq(52)
  end

  it 'should have all the start cards' do
    cards = subject.map(&:to_s)
    start_cards.each do |card|
      expect(cards).to include(card)
    end
  end

end