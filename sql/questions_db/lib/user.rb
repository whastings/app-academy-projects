require_relative "questions_database"
require_relative "question_follower"
require_relative "question_like"
require_relative 'question_record'

class User < QuestionRecord
  attr_reader :id
  attr_accessor :first_name, :last_name

  def self.find_by_name(first_name, last_name)
    find_user = <<-SQL
      SELECT
        *
      FROM
        users
      WHERE
        first_name = ?
        AND last_name = ?
    SQL

    user_data = QuestionsDatabase.instance.execute(find_user, first_name, last_name)
    self.new(user_data)
  end

  def self.attrs
    [:first_name, :last_name]
  end

  def self.table_name
    :users
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    get_karma = <<-SQL
      SELECT
        AVG(num_likes) AS karma
      FROM
        (SELECT
          COUNT(question_likes.id) AS num_likes
         FROM
           questions
         LEFT OUTER JOIN
           question_likes
           ON
             question_likes.question_id = questions.id
         WHERE
           questions.user_id = ?
         GROUP BY
           questions.id)
    SQL

    karma = @db.execute(get_karma, @id)
    karma.first['karma']
  end

  after_inherited(self)

end