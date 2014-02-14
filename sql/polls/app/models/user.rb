# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  user_name  :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many(
    :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "Poll",
    dependent: :destroy
  )

  has_many(
    :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "Response",
    dependent: :destroy
  )

  validates :user_name, uniqueness: true, presence: true

  def completed_polls
    completed_polls = []

    # Compare all polls against polls user has responded to.
    responded_polls = Poll.joins(questions: :responses)
      .select("polls.*, COUNT(*) AS responses_count")
      .where(responses: { user_id: self.id} ).group("polls.id")
    all_polls = Poll.joins(:questions)
      .select("polls.*, COUNT(*) AS questions_count").group("polls.id").count

    responded_polls.each do |responded_poll|
      if responded_poll.responses_count == all_polls[responded_poll.id]
        completed_polls << responded_poll
      end
    end
    completed_polls
  end

  def uncompleted_polls
    # Just the opposite of above, but switching back to SQL for practice.
    Poll.find_by_sql([<<-SQL, self.id])
    SELECT
      all_polls.*
    FROM
      (SELECT
          polls.*, COUNT(*) AS questions_count
        FROM
          polls
        INNER JOIN
          questions
        ON
          questions.poll_id = polls.id
        GROUP BY
          polls.id
        ) all_polls
    INNER JOIN
        (SELECT
          polls.*, COUNT(*) AS responses_count
        FROM
          polls
        INNER JOIN
          questions
        ON
          polls.id = questions.poll_id
        INNER JOIN
          answer_choices
        ON
          answer_choices.question_id = questions.id
        INNER JOIN
          responses
        ON
          responses.answer_choice_id = answer_choices.id
        WHERE
          responses.user_id = ?
        GROUP BY
          polls.id
      ) responded_polls
    ON
      responded_polls.id = all_polls.id
      AND responded_polls.responses_count != all_polls.questions_count
    GROUP BY
      all_polls.id

    SQL
  end
end
