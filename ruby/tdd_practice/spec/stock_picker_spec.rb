require 'rspec'
require 'stock_picker'

describe "#pick_stocks" do

  let(:prices) { [42, 31, 56, 13, 28, 47] }
  it 'should return the best day to buy and to sell' do
    expect(pick_stocks(prices)).to eq([3, 5])
  end

  it 'should return an empty array if passed in 0 item' do
    expect(pick_stocks([])).to eq([])
  end

  it 'should return an empty array if passed in 1 item' do
    expect(pick_stocks([4])).to eq([])
  end

end