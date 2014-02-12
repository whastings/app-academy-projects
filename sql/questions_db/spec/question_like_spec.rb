require 'rspec'
require 'question_like'

describe QuestionLike do

  describe "::likers_for_question_id" do
    subject(:likers) { QuestionLike.likers_for_question_id(1) }
    it "should show all users who liked the question" do
      expect(likers.length).to eq(2)
      expect(likers.first.first_name).to eq('Albert')
    end
  end

  describe "::num_likes_for_question_id" do
    subject(:num_likers) { QuestionLike.num_likes_for_question_id(1) }
    it "should show the number of likes for the question" do
      expect(num_likers).to eq(2)
    end
  end

  describe "::liked_questions_for_user_id" do
    subject(:questions) { QuestionLike.liked_questions_for_user_id(1) }

    it "should show all questions the user has liked" do
      expect(questions.first.id).to eq(1)
    end
  end

  describe "::most_liked_questions" do
    it "should show the most liked questions limited to n" do
      questions = QuestionLike.most_liked_questions(1)
      expect(questions.first.id).to eq(1)
    end
  end

end