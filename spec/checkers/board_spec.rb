require "rspec"

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
   0 1 2 3 4 5 6 7
0  O _ O _ O _ O _
1  _ O _ O _ O _ O
2  O _ O _ O _ O _
3  _ _ _ _ _ _ _ _
4  _ _ _ _ _ _ _ _
5  _ X _ X _ X _ X
6  X _ X _ X _ X _
7  _ X _ X _ X _ X
END
      )
    end
  end

  describe "#move" do
    before { board[0, 2] = @piece }
    it "can move a piece" do
      expect(@piece).to receive(:perform_slide).with([1, 3]).and_return(true)
      expect(board.move([0, 2], [1, 3])).to be_true
    end
    it "throws an exception if it can't move a piece" do
      expect(@piece).to receive(:perform_slide).with([1, 3]).and_return(false)
      expect(@piece).to receive(:perform_jump).with([1, 3]).and_return(false)
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

  describe "#color_pieces" do
    let(:board) { Checkers::Board.new(false) }
    let(:black_pieces) { [double("black1"), double("black2"), double("black3")] }
    before do
      black_pieces.each do |piece|
        expect(piece).to receive(:color).and_return(:black)
      end
      board[4, 4] = black_pieces[0]
      board[5, 5] = black_pieces[1]
      board[6, 6] = black_pieces[2]
    end

    it "returns all pieces for a color" do
      expect(board.color_pieces(:black)).to eq(black_pieces)
    end
  end

end
