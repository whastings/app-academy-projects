require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'question_record'

class Reply < QuestionRecord
  attr_reader :id
  attr_accessor :user_id, :question_id, :parent_reply_id, :body

  def self.all
    results = QuestionsDatabase.instance.execute('SELECT * FROM replies;')
    results.map { |result| self.new(result) }
  end

  def self.find_by_id(id)
    find_reply = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    reply_data = QuestionsDatabase.instance.execute(find_reply, id)
    self.new(*reply_data)
  end

  def self.find_by(attr, id)
    find_replies = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        #{attr}_id = ?
    SQL

    replies = QuestionsDatabase.instance.execute(find_replies, id)

    replies.map{ |reply| self.new(reply) }
  end

  def self.find_by_question_id(id)
    find_by("question", id)
  end

  def self.find_by_user_id(id)
    find_by("user", id)
  end

  def initialize(options = {})
    super()
    @id, @user_id, @question_id, @parent_reply_id, @body =
      options.values_at('id', 'user_id', 'question_id', 'parent_reply_id', 'body')
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    raise "This is the original reply" unless @parent_reply_id
    self.class.find_by_id(@parent_reply_id)
  end

  def child_replies
    find_children = <<-SQL
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL

    replies = @db.execute(find_children, @id)
    replies.map{ |reply| self.class.new(reply) }
  end
end
