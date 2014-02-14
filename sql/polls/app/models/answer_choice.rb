# == Schema Information
#
# Table name: answer_choices
#
#  id          :integer          not null, primary key
#  text        :string(255)
#  question_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class AnswerChoice < ActiveRecord::Base
  belongs_to(
    :question,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: "Question"
  )

  has_many(
    :responses,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: "Response",
    dependent: :destroy
  )

  validates :question, presence: true
end
