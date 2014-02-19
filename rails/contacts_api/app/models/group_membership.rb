# == Schema Information
#
# Table name: group_memberships
#
#  id         :integer          not null, primary key
#  group_id   :integer
#  contact_id :integer
#  created_at :datetime
#  updated_at :datetime
#

class GroupMembership < ActiveRecord::Base
  belongs_to :group
  belongs_to :contact

  validates :group_id, :contact_id, presence: true
  validate :user_has_access_to_contact

  def user_has_access_to_contact
    user = group.user
    has_access = Contact.contacts_for_user_id(user.id)
      .where("contacts.id = ?", contact_id).exists?
    unless has_access
      errors[:contact_id] << 'cannot be added to your group'
    end
  end

end
