require 'rspec'
require 'hanoi'

describe Hanoi do
  subject :hanoi do
    Hanoi.new
  end
  it 'has all its disks on one peg' do
    expect(subject.disks.first).to eq([4,3,2,1])
  end

  describe '#move' do
    it "can move from first disk to third disk" do
      subject.move(0, 2)
      expect(subject.disks.first).to eq([4,3,2])
      expect(subject.disks.last).to eq([1])
    end

    describe "invalid moves" do
      before do
        subject.disks[2] = [1]
        subject.disks[0] << 3
      end
      it "can't move a bigger disk on top of a smaller disk" do
        expect(subject.move(0, 2)).to be_false
        expect(subject.disks.first).to eq([4,3,2,1,3])
        expect(subject.disks.last).to eq([1])
      end
    end
  end

  describe '#won?' do

  end

end
