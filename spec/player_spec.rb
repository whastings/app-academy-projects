require 'rspec'
require 'player'
require 'hand'
require 'card'

describe Player do

  let(:cards) do
    [
      Card.new(1, :s),
      Card.new(10, :s),
      Card.new(11, :s),
      Card.new(12, :s),
      Card.new(13, :s)
    ]
  end
  let(:hand) { Hand.new(cards) }
  subject(:player) { Player.new("Bob", 20) }
  before { player.hand = hand }

  describe '#hand' do
    its(:hand) { should == hand }
  end

  describe '#discard_cards' do
    it 'should discard cards that user selects' do
      subject.stub(:get_user_input).and_return("1 2 4")
      expect(subject.discard_cards).to eq(3)
      expect(subject.hand.contents).to eq([Card.new(11, :s), Card.new(13, :s)])
    end

    it 'should discard nothing if user selects nothing' do
      subject.stub(:get_user_input).and_return("")
      expect(subject.discard_cards).to eq(0)
      expect(subject.hand.contents).to eq(cards)
    end

    it 'should raise error if user chooses invalid card numbers' do
      subject.stub(:get_user_input).and_return("0,6,100")
      expect { subject.discard_cards }.to raise_error(ArgumentError)
    end

    it "should raise error if user tries to discard more than 3 cards" do
      subject.stub(:get_user_input).and_return("1 2 4 5")
      expect { subject.discard_cards }.to raise_error(ArgumentError)
    end
  end

  describe '#place_bet' do
    let(:highest_bet) { 5 }
    it "should return amount higher than highest bet if player raises" do
      subject.stub(:get_user_input).and_return("r", "15")
      expect(subject.place_bet(highest_bet)).to eq(15)
    end

    it 'should raise error if user chooses to raise more than he has' do
      subject.stub(:get_user_input).and_return("r", "25")
      expect { subject.place_bet(highest_bet) }.to raise_error(ArgumentError)
    end

    it "should raise error if player tries to raise less than highest best" do
      subject.stub(:get_user_input).and_return("r", "4")
      expect { subject.place_bet(highest_bet) }.to raise_error(ArgumentError)
    end

    it "should decrease user's pot by amount raised" do
      subject.stub(:get_user_input).and_return("r", "6")
      expect { subject.place_bet(highest_bet) }.to change { subject.pot }.by(-6)
    end

    context "when player sees" do
      before { subject.stub(:get_user_input).and_return("s") }

      it "should return amount equal to highest bet if player sees" do
        expect(subject.place_bet(highest_bet)).to eq(highest_bet)
      end

      it "should decrease player's pot by highest bet if player sees" do
        expect { subject.place_bet(highest_bet) }.to change { subject.pot }.by(-5)
      end

      it "should not let player see if highest bet is more than her pot" do
        subject.pot = 3
        expect { subject.place_bet(highest_bet) }.to raise_error(ArgumentError)
      end
    end

    it "should return -1 if player folds" do
      subject.stub(:get_user_input).and_return("f")
      expect(subject.place_bet(highest_bet)).to eq(-1)
    end

    it "should raise error if user enters invalid first choice" do
      subject.stub(:get_user_input).and_return("y")
      expect { subject.place_bet(highest_bet) }.to raise_error(ArgumentError)
    end

  end

  describe 'adding of cards' do

    let(:card_to_add) { [Card.new(4, :c)] }
    it 'should add cards' do
      subject.add_cards(card_to_add)
      expect(subject.hand.contents.length).to eq(6)
    end

  end

end
