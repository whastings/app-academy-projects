require_relative "questions_database"

class QuestionRecord

  def self.all
    results = QuestionsDatabase.instance.execute("SELECT * FROM #{table_name};")
    results.map { |result| self.new(result) }
  end

  def initialize(options = {} )
    set_attrs(options)
    @id = options['id']
    @db = QuestionsDatabase.instance
  end

  def save
    self.id.nil? ? create : update
  end

  private
  def self.attrs
    raise NotImplementedError, "You need to define attributes!"
  end

  def attrs
    self.class.attrs
  end

  def set_attrs(options)
    attrs.each do |attr|
      self.instance_variable_set("@#{attr}", options["#{attr}"])
    end
  end

  def self.table_name
     raise NotImplementedError, "You need to define table name!"
  end

  def table_name
     self.class.table_name
  end

  def attr_values
    attrs.map{ |attr| self.send(attr) }
  end

  def create
    attrs_placeholders = attrs.map{|attr| "?" }.join(', ')

    create_obj = <<-SQL
      INSERT INTO
        #{table_name} (#{attrs.join(', ')})
      VALUES
        (#{attrs_placeholders})
    SQL

    @db.execute(create_obj, *attr_values)
    @id = @db.last_insert_row_id
  end

  def update
    attrs_set = attrs.map{|attr| "#{attr} = ?" }.join(', ')
    update_obj = <<-SQL
      UPDATE
        #{table_name}
      SET
        #{attrs_set}
      WHERE
        id = ?
    SQL
    @db.execute(update_obj, *attr_values, @id)
  end
end