# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  poll_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
  belongs_to(
    :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: "Poll"
  )

  has_many(
    :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: "AnswerChoice",
    dependent: :destroy
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

  validates :poll, presence: true

  def results
    responses_hash = {}
    self.responses.select("answer_choices.text, COUNT(*) AS responses_count")
      .joins(:answer_choice).group("answer_choices.id").each do |title|
        responses_hash[title.text] = title.responses_count
    end
    responses_hash
  end

end
