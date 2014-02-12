require_relative "questions_database"
require_relative "user"
require_relative "reply"
require_relative "question_follower"
require_relative "question_like"
require_relative 'question_record'

class Question < QuestionRecord
  attr_reader :id
  attr_accessor :title, :body, :user_id

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def self.attrs
    [:title, :body, :user_id]
  end

  def self.table_name
    :questions
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def followers
    QuestionFollower.followers_for_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  after_inherited(self)
end