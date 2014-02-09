require 'rspec'
require 'card'


describe Card do

  subject(:card) do
    Card.new(1,:s)
  end

  it "should have number and suit" do
    expect(subject.num).to eq(1)
    expect(subject.suit).to eq(:s)
  end

end
