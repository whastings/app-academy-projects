require_relative "questions_database"

class QuestionRecord

  def initialize
    @db = QuestionsDatabase.instance
  end

  def save
    self.id.nil? ? create : update
  end

  protected
  def create
    create_user = <<-SQL
      INSERT INTO
        users (fname, lname)
      VALUES
        (?, ?)
    SQL

    @db.execute(create_user, @first_name, @last_name)
    @id = @db.last_insert_row_id
  end

  def update
    update_user = <<-SQL
      UPDATE
        users
      SET
        fname = ?, lname = ?
      WHERE
      users.id = ?
    SQL
    @db.execute(update_user, @first_name, @last_name, @id)
  end
end