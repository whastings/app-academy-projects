# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  validates_presence_of :name, :email, :user_id
  validates_uniqueness_of :email

  belongs_to(:owner,
    foreign_key: :user_id,
    class_name: "User"
  )

  has_many :contact_shares
  has_many :shared_users, through: :contact_shares, source: :user

  def self.contacts_for_user_id(user_id)
    Contact.joins("LEFT OUTER JOIN contact_shares ON (contact_shares.contact_id = contacts.id)")
      .where("contact_shares.user_id = ? OR contacts.user_id = ?", user_id, user_id)
      .group("contacts.id")
  end
end
