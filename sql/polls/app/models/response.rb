# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

class Response < ActiveRecord::Base
  belongs_to(
    :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User",
  )

  belongs_to(
    :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: "AnswerChoice"
  )

  validates :respondent, presence: true
  validates :answer_choice, presence: true
  validate :respondent_has_not_already_answered_question

  validate :author_cant_respond_to_poll

  private


  def author_cant_respond_to_poll
    if User.joins(authored_polls: { questions: :answer_choices  } )
      .where(answer_choices: {id: answer_choice_id})
      .distinct.first.id == user_id

      errors[:respondent] << "cant vote on your own poll"
    end

  end

  def respondent_has_not_already_answered_question
    if existing_responses.count > 1 || (existing_responses.first != nil &&
       existing_responses.first.id != self.id)
      errors[:respondent] << "can't vote more than once for the same question"
    end
    true
  end


  def existing_responses
    Response.find_by_sql([<<-SQL, answer_choice_id, user_id])
    SELECT
      responses.*
    FROM
      responses
    INNER JOIN
      answer_choices
    ON
      responses.answer_choice_id = answer_choices.id
    WHERE
      answer_choices.question_id = (SELECT
        answer_choices.question_id
      FROM
        answer_choices
      WHERE
        answer_choices.id = ?
      )
      AND
       responses.user_id = ?
    SQL
  end

end
