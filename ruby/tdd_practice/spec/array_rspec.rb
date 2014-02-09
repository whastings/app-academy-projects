require 'rspec'
require 'array.rb'

describe Array do
  describe '#my_uniq' do
    it 'should not return duplicate values' do
      expect([1,1,2,2,3,3].my_uniq).to eq([1,2,3])
    end
    it 'should not change order' do
      expect([3,1,2,1,3,2].my_uniq).to eq([3,1,2])
    end
  end

  describe '#two_sum' do
    it 'returns the index of numbers that sum to 0' do
      expect([-1, 0, 2, -2, 1].two_sum).to eq([[0, 4], [2, 3]])
    end
    it 'smaller indexes come first regardless of array order' do
      result = [-1, 0, 2, -2, 1].shuffle.two_sum
      result.map! { |array| array.inject(:+) }
      expect(result[0]).to be < result[1]
    end
  end
end