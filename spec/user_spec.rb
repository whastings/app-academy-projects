require 'rspec'
require 'user'

describe User do
  subject(:user) { User.find_by_id(3) }

  describe "#average_karma" do
    it "should show the average likes per question for a user" do
      expect(user.average_karma).to eq(1.5)
    end
  end

end
