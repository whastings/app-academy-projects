# == Schema Information
#
# Table name: polls
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  author_id  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Poll < ActiveRecord::Base
  belongs_to(
    :author,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: "User"
  )

  has_many(
    :questions,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: "Question",
    dependent: :destroy
  )

  validates :author, presence: true

end
