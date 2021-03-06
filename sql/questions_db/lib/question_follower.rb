require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'question_record'

class QuestionFollower < QuestionRecord
  attr_reader :id
  attr_accessor :user_id, :question_id

  def self.followers_for_question_id(question_id)
    find_followers = <<-SQL
      SELECT
        *
      FROM
        question_followers
      INNER JOIN
        users
        ON
          question_followers.user_id = users.id
      WHERE
        question_followers.question_id = ?
    SQL
    followers = QuestionsDatabase.instance.execute(find_followers, question_id)
    followers.map { |follower| User.new(follower) }
  end

  def self.followed_questions_for_user_id(user_id)
    find_questions = <<-SQL
      SELECT
        *
      FROM
        question_followers
      INNER JOIN
        questions
      ON
        question_followers.question_id = questions.id
      WHERE
        question_followers.user_id = ?
    SQL
    questions = QuestionsDatabase.instance.execute(find_questions, user_id)
    questions.map { |question| Question.new(question) }
  end

  def self.most_followed_questions(n)
    raise ArgumentError, 'Number is smaller than one.' if n < 1
    most_followed = <<-SQL
      SELECT
        questions.*
      FROM
        questions
      INNER JOIN
        question_followers
        ON
        questions.id = question_followers.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_followers.id) DESC
      LIMIT
        ?
    SQL

    questions = QuestionsDatabase.instance.execute(most_followed, n)
    questions.map { | question| Question.new(question) }
  end

  def self.attrs
    [:user_id, :question_id]
  end

  def self.table_name
    :question_followers
  end

  after_inherited(self)
end