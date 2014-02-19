# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  group_name :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Group < ActiveRecord::Base
  belongs_to :user
  has_many :group_memberships
  has_many :contacts, through: :group_memberships

  validates :group_name, :user_id, presence: true
end
