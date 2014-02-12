require_relative "questions_database"
require_relative "user"
require_relative "question"
require_relative 'question_record'

class QuestionLike < QuestionRecord
  attr_reader :id
  attr_accessor :id, :user_id, :question_id

  def self.find_by_id(id)
    find_question = <<-SQL
      SELECT
        *
      FROM
        question_likes
      WHERE
        id = ?
    SQL

    question_data = QuestionsDatabase.instance.execute(find_question, id)
    self.new(*question_data)
  end

  def self.likers_for_question_id(question_id)
    find_likers = <<-SQL
      SELECT
        *
      FROM
        question_likes
      INNER JOIN
        users
        ON
          question_likes.user_id = users.id
      WHERE
        question_likes.question_id = ?
    SQL
    likers = QuestionsDatabase.instance.execute(find_likers, question_id)
    likers.map { |liker| User.new(liker) }
  end

  def self.num_likes_for_question_id(question_id)
    get_count = <<-SQL
      SELECT
        COUNT(*) count
      FROM
        question_likes
      WHERE
        question_likes.question_id = ?
    SQL
    count = QuestionsDatabase.instance.execute(get_count, question_id)
    count.first['count']
  end

  def self.liked_questions_for_user_id(user_id)
    find_questions = <<-SQL
      SELECT
        *
      FROM
        question_likes
      INNER JOIN
        questions
        ON
          question_likes.question_id = questions.id
      WHERE
        question_likes.user_id = ?
    SQL
    questions = QuestionsDatabase.instance.execute(find_questions, user_id)
    questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    raise ArgumentError, 'Number is smaller than one.' if n < 1
    most_liked = <<-SQL
      SELECT
        questions.*
      FROM
        questions
      INNER JOIN
        question_likes
        ON
        questions.id = question_likes.question_id
      GROUP BY
        questions.id
      ORDER BY
        COUNT(question_likes.id) DESC
      LIMIT
        ?
    SQL

    questions = QuestionsDatabase.instance.execute(most_liked, n)
    questions.map { | question| Question.new(question) }
  end

  def self.attrs
    [:user_id, :question_id]
  end

  def self.table_name
    :question_likes
  end

end