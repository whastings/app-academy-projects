require "rspec"

describe Checkers::Board do
  let(:board) { Checkers::Board.new }
  subject { board }

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

end
