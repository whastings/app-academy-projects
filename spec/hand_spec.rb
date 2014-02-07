require 'rspec'
require 'hand'
require 'card'


describe Hand do

  let(:cards) do
    cards = [
      Card.new(4, :s),
      Card.new(4, :h),
      Card.new(11, :c),
      Card.new(1, :d),
      Card.new(8, :s)
    ]
  end

  subject(:hand) { Hand.new(cards) }

  it 'should have a hand' do
    expect(hand.contents).to eq(cards)
  end

  describe "#has_pair?" do
    it "should return true if hand has two cards with same number" do
      expect(hand).to have_pair
    end
  end

  describe "#has_three_kind?" do
    before do
      subject.contents[2] = Card.new(4, :c)
    end

    it "should return true if hand has three same number cards" do
      expect(hand).to have_three_kind
    end
  end

  describe "#has_two_pair?" do

    before do
      subject.contents[2] = Card.new(8, :c)
    end

    it "should return true if hand has two pairs" do
      expect(hand).to have_two_pair
    end

  end

  describe '#has_straight?' do
    before do
      subject.contents = [
        Card.new(1, :s),
        Card.new(2, :h),
        Card.new(3, :c),
        Card.new(4, :d),
        Card.new(5, :s)
      ]
    end

    it "should return true if you have a straight" do
      expect(subject).to have_straight
    end

    describe 'highest straight' do

      before do
        subject.contents = [
          Card.new(1, :s),
          Card.new(10, :h),
          Card.new(11, :c),
          Card.new(12, :d),
          Card.new(13, :s)
        ]
      end

      it "should return true if you have a face card straight with ace" do
        expect(subject).to have_straight
      end

    end

  end

  describe '#has_flush?' do
    before do
      subject.contents = [
        Card.new(1, :s),
        Card.new(2, :s),
        Card.new(3, :s),
        Card.new(4, :s),
        Card.new(5, :s)
      ]
    end
    it "should return true if you have five cards of the same suite" do
      expect(subject).to have_flush
    end
  end

  describe '#has_full_house?' do
    before do
      subject.contents = [
        Card.new(4, :s),
        Card.new(4, :s),
        Card.new(4, :s),
        Card.new(3, :s),
        Card.new(3, :s)
      ]
    end
    it "should return true if you have a full house" do
      expect(subject).to have_full_house
    end
  end

  describe '#has_four_kind?' do
    before do
      subject.contents = [
        Card.new(4, :s),
        Card.new(4, :s),
        Card.new(4, :s),
        Card.new(4, :s),
        Card.new(3, :s)
      ]
    end
    it "should return true if you have a four of the same number" do
      expect(subject).to have_four_kind
    end
  end


  describe '#has_straight_flush?' do
    before do
      subject.contents = [
        Card.new(4, :s),
        Card.new(5, :s),
        Card.new(6, :s),
        Card.new(7, :s),
        Card.new(8, :s)
      ]
    end
    it "should return true if you have a straight flush" do
      expect(subject).to have_straight_flush
    end
  end


  describe '#has_royal_flush?' do
    before do
      subject.contents = [
        Card.new(1, :s),
        Card.new(10, :s),
        Card.new(11, :s),
        Card.new(12, :s),
        Card.new(13, :s)
      ]
    end
    it "should return true if you have a four of the same number" do
      expect(subject).to have_royal_flush
    end
  end

end