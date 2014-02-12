require_relative 'questions_database'
require_relative 'user'
require_relative 'question'
require_relative 'question_record'

class Reply < QuestionRecord
  attr_reader :id
  attr_accessor :user_id, :question_id, :parent_reply_id, :body

  def self.attrs
    [:user_id, :question_id, :parent_reply_id, :body]
  end

  def self.table_name
    :replies
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

  after_inherited(self)
end
