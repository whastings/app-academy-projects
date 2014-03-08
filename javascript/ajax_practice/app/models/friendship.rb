# == Schema Information
#
# Table name: friendships
#
#  id          :integer          not null, primary key
#  friender_id :integer          not null
#  friendee_id :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Friendship < ActiveRecord::Base
  belongs_to :friender, :class_name => "User"
  belongs_to :friendee, :class_name => "User"

  validates :friender_id, :friendee_id, :presence => true
  validates :friender_id, :uniqueness => { scope: :friendee_id }

  def self.can_friend?(friendee_id, friender_id)
    return false if friendee_id == friender_id

    !self.where(friendee_id: friendee_id, friender_id: friender_id).exists?
  end

  def self.can_unfriend?(friendee_id, friender_id)
    return false if friendee_id == friender_id

    self.where(friendee_id: friendee_id, friender_id: friender_id).exists?
  end
end
