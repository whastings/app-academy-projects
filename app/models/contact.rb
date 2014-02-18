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


end
