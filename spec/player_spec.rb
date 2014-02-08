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
  subject(:player) { Player.new("Bob", hand, 10) }

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
  end

  describe '#turn_choice' do

    it "should return amount to raise if player raises" do
      subject.stub(:get_user_input).and_return("r", "5")
      expect(subject.turn_choice).to eq(5)
    end

    it 'should raise error if user chooses to raise more than he has' do
      subject.stub(:get_user_input).and_return("r", "12")
      expect { subject.turn_choice }.to raise_error(ArgumentError)
    end

    it "should decrease user's pot by amount raised" do
      subject.stub(:get_user_input).and_return("r", "4")
      expect { subject.turn_choice }.to change { subject.pot }.by(-4)
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