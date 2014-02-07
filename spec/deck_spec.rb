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

  describe '#shuffle' do
    let!(:ordered_cards) { subject.cards.dup }
    it "should randomize card order" do
      subject.shuffle
      expect(subject.cards).to_not eq(ordered_cards)
    end
  end

  describe '#pop' do

  it "should pop off 'top' card" do
    expect(subject.pop.to_s).to eq('13c')
    expect(subject.pop.to_s).to eq('13s')
  end

  end

  describe '#draw' do

    it "should draw numbers of cards" do
      cards_drawn = subject.draw(5).map(&:to_s)
      expect(cards_drawn).to eq(['12c', '13h', '13d', '13s', '13c'].reverse)
    end

  end



end