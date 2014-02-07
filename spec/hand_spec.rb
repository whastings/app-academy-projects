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

  let(:royal_flush) do
    [
      Card.new(1, :s),
      Card.new(10, :s),
      Card.new(11, :s),
      Card.new(12, :s),
      Card.new(13, :s)
    ]
  end

  let(:full_house) do
    [
      Card.new(4, :s),
      Card.new(4, :s),
      Card.new(4, :s),
      Card.new(3, :s),
      Card.new(3, :s)
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

    it "should return false for a full house" do
      subject.contents = full_house
      expect(subject).to_not have_straight
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
      subject.contents = full_house
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
    before { subject.contents = royal_flush }
    it "should return true if you have a four of the same number" do
      expect(subject).to have_royal_flush
    end
  end

  describe '#score' do

    it "should return 9 if hand is royal flush" do
      subject.contents = royal_flush
      expect(subject.score).to eq(9)
    end

    it "should return 6 if hand is full house" do
      subject.contents = full_house
      expect(subject.score).to eq(6)
    end

    it "should return 0 if you have crap" do
      subject.contents = [
        Card.new(1, :d),
        Card.new(5, :s),
        Card.new(6, :s),
        Card.new(7, :s),
        Card.new(8, :s)
      ]
      expect(subject.score).to eq(0)
    end

  end

  describe '#highest_card' do

    it 'should return 14 if there is an ace' do
      expect(subject.highest_card).to eq(14)
    end

    it 'should return 4 if that is the highest card' do
      subject.contents = full_house
      expect(subject.highest_card).to eq(4)
    end

  end


end