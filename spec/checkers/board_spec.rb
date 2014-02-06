require "rspec"

describe Checkers::Board do
  let(:board) { Checkers::Board.new }
  subject { board }
  let(:piece) { "" }
  before do
    piece = double("piece", color: :white)
  end

  describe "#initialize" do
    it "should lay out the board correctly" do
      expect(board.render).to eq(
<<END
O_O_O_O_
_O_O_O_O
O_O_O_O_
________
________
_X_X_X_X
X_X_X_X_
_X_X_X_X
END
      )
    end
  end

  describe "#move" do
    before { board[0, 2] = piece }
    it "can move a piece" do
      allow(piece).to receive(:perform_slide).and_return(true)
      expect(piece).to receive(:perform_slide).with([1, 3])
      expect(board.move([0, 2], [1, 3])).to be_true
      expect(board[1, 3]).to eq(piece)
    end
    it "throws an exception if it can't move a piece" do
      allow(piece).to receive(:perform_slide).and_return(false)
      expect(piece).to receive(:perform_slide).with([1, 3])
      expect { board.move([0, 2], [1, 3]) }.to raise_error(ArgumentError)
      expect(board[1, 3]).to_not eq(piece)
    end
    it "throws an exception if piece to move doesn't exist" do
      board[0, 2] = nil
      expect { board.move([0, 2], [1, 3]) }.to raise_error(ArgumentError)
      expect(board[1, 3]).to_not eq(piece)
    end
  end

end
