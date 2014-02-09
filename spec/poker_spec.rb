require 'rspec'
require 'poker'

describe Poker do
  let!(:players) do
    [double("Weyman", pot: 20, discard_cards: 2),
     double("Will", pot: 5, discard_cards: 3)]
  end
  subject(:poker) { Poker.new(players) }

  describe "#deal_cards" do
    it "should give each player five cards" do
      players.each do |player|
        expect(player).to receive(:add_cards) do |cards|
          expect(cards.length).to eq(5)
        end
      end
      subject.deal_cards
    end
  end

  describe '#play_draw' do
    it "should give a player the number of cards they discard" do
      expect(players.first).to receive(:add_cards) do |array|
        expect(array.length).to eq(2)
      end
      expect(players.last).to receive(:add_cards)
      subject.play_draw
    end
  end

  describe "#take_bets" do
    describe "taking bets from all players" do
      before do
        players.each do |player|
         expect(player).to receive(:place_bet).and_return(1)
        end
      end
      it "should ask all players to place bets" do
        subject.take_bets
      end

      it "should increase its pot by the amount all players return" do
        expect { subject.take_bets }.to change { subject.pot }.by(2)
      end
    end

    it "should pass successive players the current highest bet" do
      expect(players.first).to receive(:place_bet).with(1).and_return(2)
      expect(players.last).to receive(:place_bet).with(2).and_return(2)
      subject.take_bets
    end

    it "should remove a player who folds from the game" do
      expect(players.first).to receive(:place_bet).and_return(-1)
      expect(players.last).to receive(:place_bet).and_return(1)
      subject.take_bets
      expect(subject.players).to eq([players.last])
    end
  end

  describe "#determine_winner" do
    context "when there's a winner" do
      before do
        expect(players.first).to receive(:score).and_return(5).at_least(:once)
        expect(players.last).to receive(:score).and_return(4).at_least(:once)
      end
      it "should return the player with the highest score" do
        expect(subject.determine_winner).to eq([players.first])
      end
    end

    context "when there's a tie" do
      before do
        expect(players.first).to receive(:score).and_return(5).at_least(:once)
        expect(players.last).to receive(:score).and_return(5).at_least(:once)
      end
      it "should return the tied players" do
        expect(subject.determine_winner).to eq players
      end
    end
  end

end
