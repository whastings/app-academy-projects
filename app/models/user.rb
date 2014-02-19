# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  username   :string(255)
#

class User < ActiveRecord::Base
  validates_presence_of :name, :email, :username
  validates_uniqueness_of :email, :username

  has_many :contacts
  has_many :contact_shares

  has_many :shared_contacts,
    through: :contact_shares,
    source: :contact

  def favorites
    Contact.contacts_for_user_id(self.id)
      .where(<<-SQL, true, true, self.id)
        contacts.favorite = ? OR
        (contact_shares.favorite = ? AND contact_shares.user_id = ?)
      SQL
  end

  def favorite!(contact_id)
    our_contact_ids = self.contacts.pluck(:id)
    shared_contact_ids = self.shared_contacts.pluck(:id)

    puts contact_id

    if our_contact_ids.include?(contact_id)
      Contact.find(contact_id).update_attributes(:favorite => true)
    elsif shared_contact_ids.include?(contact_id)
      ContactShare.find_by(:contact_id => contact_id, :user_id => self.id)
        .update_attributes(:favorite => true)
    else
      raise "you can't favorite this contact!"
    end
  end
end
