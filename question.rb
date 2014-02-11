require_relative "questions_database"

class Question
  attr_accessor :title, :body, :user_id
  attr_reader :id

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
    self.new(question_data)
  end

  def self.find_by_author(id)
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

  def initialize(options = {})
    @id, @title, @body, @user_id =
      options.values_at('id', 'title', 'body', 'user_id')
    @db = QuestionsDatabase.instance
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end


end