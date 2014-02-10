require "rspec"

describe Checkers::Game do
  subject { Checkers::Game.new }
  let(:board) { Checkers::Board.new(false) }
  before { subject.board = board }

  describe "#player_lost?" do
    before do
      [[0, 0], [2, 0]].each do |position|
        board[*position] = double("piece", color: :white, can_move?: false)
      end
    end

    it "should return true if the player has no more pieces" do
      expect(subject.player_lost?(:black)).to be_true
    end

    it "should return true if the player's remaining pieces can't move" do
      expect(subject.player_lost?(:white)).to be_true
    end
  end

  describe "#won?" do
    before do
      board[4, 4] = double("free piece", color: :black, can_move?: true)
    end

    it "should return true if one player has lost and the other hasn't" do
      expect(subject).to be_won
    end
  end

  describe "#draw?" do
    it "should return true when both players have lost" do
      expect(subject).to be_draw
    end
  end

  describe "#winner" do
    it "should return nil when there's no winner" do
      expect(subject.winner).to be_nil
    end

    context "when there is a winner" do
      before do
        board[4, 4] = double("free piece", color: :black, can_move?: true)
      end

      it "should return the winner" do
        expect(subject.winner).to eq(:black)
      end
    end
  end

end
