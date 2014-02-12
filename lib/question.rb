require_relative "questions_database"
require_relative "user"
require_relative "reply"
require_relative "question_follower"
require_relative "question_like"
require_relative 'question_record'

class Question < QuestionRecord
  attr_reader :id
  attr_accessor :title, :body, :user_id

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM questions;')
    results.map { |result| self.new(result) }
  end

  def self.find_by_id(id)
    find_question = <<-SQL
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    question_data = QuestionsDatabase.instance.execute(find_question, id)
    self.new(*question_data)
  end

  def self.find_by_author_id(id)
    find_questions = <<-SQL
      SELECT
        *
      FROM
        questions
      WHERE
        user_id = ?
    SQL

    questions_data = QuestionsDatabase.instance.execute(find_questions, id)
    questions_data.map{ |question| self.new(question) }
  end

  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options = {})
    @id, @title, @body, @user_id =
      options.values_at('id', 'title', 'body', 'user_id')
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

end