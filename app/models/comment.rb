# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  contact_id :integer
#  body       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  validates :user_id, :contact_id, :body, :presence => true
  validate :user_has_access_to_contact

  belongs_to :user
  belongs_to :contact

  def user_has_access_to_contact
    user = group.user
    has_access = Contact.contacts_for_user_id(user.id)
      .where("contacts.id = ?", contact_id).exists?
    unless has_access
      errors[:contact_id] << 'cannot be added to your group'
    end
  end
end
