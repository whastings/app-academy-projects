require "rspec"

describe Checkers::Piece do
  before do
    @board = double("board", :[] => nil)
    @piece = Checkers::Piece.new([0, 2], :white, @board)
  end
  subject { @piece }

  describe "#perform_slide" do
    context "with a bad move" do
      it "can't move forward" do
        expect(@piece.perform_slide([0, 3])).to be_false
      end

      it "can't move backward" do
        expect(@piece.perform_slide([0, 1])).to be_false
      end

      it "can't move backward diagonally" do
        @piece.position = [0, 4]
        expect(@piece.perform_slide([1, 3])).to be_false
      end

      it "can't move off of the board" do
        expect(@piece.perform_slide([-1, 2])).to be_false
      end

      describe "can't move to an occupied position" do
        let(:piece_in_way) { Checkers::Piece.new([1, 3], :black, @board) }
        specify do
          allow(@board).to receive(:[]).and_return(piece_in_way)
          expect(@board).to receive(:[]).with(1, 3)
          expect(@piece.perform_slide([1, 3])).to be_false
        end
      end
    end

    context "with a valid move" do
      before { @piece.position = [2, 2] }
      it "can move one space diagonally to the right" do
        expect(@piece.perform_slide([3, 3])).to be_true
        expect(@piece.position).to eq([3, 3])
      end
      it "can move one space diagonally to the left" do
        expect(@piece.perform_slide([1, 3])).to be_true
        expect(@piece.position).to eq([1, 3])
      end
    end

    context "as a king" do
      before do
        @piece.position = [0, 4]
        @piece.make_king
      end
      it "can move backward" do
        expect(@piece.perform_slide([1, 3])).to be_true
        expect(@piece.position).to eq([1, 3])
      end
    end
  end

  describe "#perform_jump" do
    before { @piece.position = [0, 2] }
    it "can jump over a piece to an empty space" do
      expect(@board).to receive(:[]).with(1, 3)
        .and_return(double("other piece"))
      expect(@piece.perform_jump([2, 4])).to be_true
    end

    it "can't jump over a piece if the next space is occupied" do
      expect(@board).to receive(:[]).with(1, 3)
        .and_return(double("other piece"))
      expect(@board).to receive(:[]).with(2, 4)
        .and_return(double("blocking piece"))
      expect(@piece.perform_jump([2, 4])).to be_false
    end
  end

end
