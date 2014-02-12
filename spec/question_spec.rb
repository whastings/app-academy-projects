require 'rspec'
require 'question'

describe Question do
  describe "::find_by_author_id" do
    it "should return all the users questions" do
      expect(Question.find_by_user_id(3).length).to eq(3)
    end
  end

end
