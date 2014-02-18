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

  has_many :shared_contacts, through: :contact_shares, source: :contact
end
