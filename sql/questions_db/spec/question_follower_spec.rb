require 'rspec'
require 'question_follower'

describe QuestionFollower do
  subject(:question_follower) { QuestionFollower.find_by_id(1) }

  describe "::followers_for_question_id" do
    it "list of all user followers for question" do
      follower = QuestionFollower.followers_for_question_id(1)
      expect(follower.first.first_name).to eq('Albert')
    end
  end

  describe "::followed_questions_for_user_id" do
    it "list all questions followed by a user" do
      questions = QuestionFollower.followed_questions_for_user_id(2)
      expect(questions.first.id).to eq(2)
    end
  end

  describe "::most_followed_questions" do
    it "should show the most followed questions limited to n" do
      questions = QuestionFollower.most_followed_questions(1)
      expect(questions.first.id).to eq(1)
    end
  end
end