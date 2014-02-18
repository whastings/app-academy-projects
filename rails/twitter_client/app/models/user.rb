require "status"
# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  screen_name     :string(255)      not null
#  twitter_user_id :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base

  validates :screen_name, :twitter_user_id, presence: true, uniqueness: true

  has_many :statuses, primary_key: :twitter_user_id, foreign_key: :twitter_user_id, class_name: "Status"

  def self.fetch_by_screen_name!(name)
    user = User.where(screen_name: name)
    Status.get_by_twitter_user_id(user.first.twitter_user_id)
  end

  def self.get_by_screen_name(name)
    user = User.where(screen_name: name).first
    unless user
      raw_user = TwitterSession.get("users/show", screen_name: name)
      user = parse_twitter_user(raw_user)
      user.save!
    end
    fetch_by_screen_name!(user.screen_name)
  end

  def self.parse_twitter_user(user_json)
    user_data = JSON.parse(user_json)
    User.new(
      twitter_user_id: user_data["id"],
      screen_name: user_data["screen_name"]
    )
  end

  def fetch_statuses!
    self.class.fetch_by_screen_name!(self.screen_name)
  end

end
