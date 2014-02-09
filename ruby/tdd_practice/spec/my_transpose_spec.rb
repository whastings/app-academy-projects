require 'rspec'
require 'my_transpose'

describe '#my_transpose' do

  it "should transpose an array three arrays" do
    expect(
      my_transpose([
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8]
      ])
    ).to eq(
      [[0, 3, 6],
      [1, 4, 7],
      [2, 5, 8]]
    )
  end

  it "should transpose an array of four arrays" do
    expect(
      my_transpose([
        [0, 1, 2],
        [3, 4, 5],
        [6, 7, 8],
        [9, 10, 11]
      ])
    ).to eq(
      [[0, 3, 6, 9],
      [1, 4, 7, 10],
      [2, 5, 8, 11]]
    )
  end

  it "should transpose an array of arrays with four elements" do
    expect(
      my_transpose([
        [0, 1, 2, 3],
        [4, 5, 6, 7],
        [7, 8, 9, 10],
        [11, 12, 13, 14]
      ])
    ).to eq(
      [[0, 4, 7, 11],
      [1, 5, 8, 12],
      [2, 6, 9, 13],
      [3, 7, 10, 14]]
    )
  end

end