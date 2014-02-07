require "rspec"

def piece_double
  double(
    "piece",
    color: :white,
    make_king: true,
    perform_slide: true,
    pos_x: 0,
    pos_y: 0
  )
end

describe Checkers::Board do
  let(:board) { Checkers::Board.new }
  subject { board }
  let!(:piece) { @piece }
  before do
    @piece = Checkers::Piece.new([0, 2], :white, board)
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
    before { board[0, 2] = @piece }
    it "can move a piece" do
      allow(@piece).to receive(:perform_slide).and_return(true)
      expect(@piece).to receive(:perform_slide).with([1, 3])
      expect(board.move([0, 2], [1, 3])).to be_true
    end
    it "throws an exception if it can't move a piece" do
      allow(@piece).to receive(:perform_slide).and_return(false)
      expect(@piece).to receive(:perform_slide).with([1, 3])
      allow(@piece).to receive(:perform_jump).with([1, 3])
      expect { board.move([0, 2], [1, 3]) }.to raise_error(ArgumentError)
      expect(board[1, 3]).to_not eq(@piece)
    end
    it "throws an exception if piece to move doesn't exist" do
      board[0, 2] = nil
      expect { board.move([0, 2], [1, 3]) }.to raise_error(ArgumentError)
      expect(board[1, 3]).to_not eq(@piece)
    end
    it "can have a piece jump another piece" do
      board[3, 3] = double("piece to jump", color: :black)
      expect(board.move([2, 2], [4, 4])).to be_true
      expect(board[3, 3]).to be_nil
    end

    context "when moved piece reaches the other side" do
      before do
        board[0, 6] = @piece
        board[1, 7] = nil
        @piece.position = [0, 6]
      end
      it "should make piece a king" do
        expect(@piece).to receive(:make_king).once
        board.move([0, 6], [1, 7])
      end
    end
  end

end
