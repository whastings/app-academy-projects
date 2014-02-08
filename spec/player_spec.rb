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
      subject.discard_cards
      expect(subject.hand.contents).to eq([Card.new(11, :s), Card.new(13, :s)])
    end

    it 'should discard nothing if user selects nothing' do
      subject.stub(:get_user_input).and_return("")
      subject.discard_cards
      expect(subject.hand.contents).to eq(cards)
    end

    it 'should raise error if user chooses invalid card numbers' do
      subject.stub(:get_user_input).and_return("0,6,100")
      expect { subject.discard_cards }.to raise_error(ArgumentError)
    end
  end

end