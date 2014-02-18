# == Schema Information
#
# Table name: statuses
#
#  id                :integer          not null, primary key
#  body              :string(255)      not null
#  twitter_status_id :string(255)      not null
#  twitter_user_id   :string(255)      not null
#  created_at        :datetime
#  updated_at        :datetime
#

require 'open-uri'

class Status < ActiveRecord::Base
  validates :twitter_status_id, :twitter_user_id, :body, :presence => true
  validates :twitter_status_id, uniqueness: true

  belongs_to :user,  primary_key: :twitter_user_id, foreign_key: :twitter_user_id, class_name: "User"

  def self.fetch_by_user_id!(twitter_user_id)
    raw_json = TwitterSession.get("statuses/user_timeline", user_id: twitter_user_id )
    statuses = parse_json(raw_json)
    already_saved = Status.where(twitter_user_id: twitter_user_id)
      .pluck(:twitter_status_id)
    to_save = statuses.select do |status|
      !already_saved.include?(status.twitter_status_id)
    end
    to_save.each(&:save!)
    statuses
  end

  def self.parse_json(raw_json)
    JSON.parse(raw_json).map do |raw_status|
      if raw_status["errors"]
        raise raw_status["errors"].first["message"]
      end

      body = raw_status["text"]
      status_id = raw_status["id_str"]
      user_id = raw_status["user"]["id_str"]
      self.new(
        twitter_status_id: status_id,
        twitter_user_id: user_id,
        body: body
      )
    end
  end


  def self.post(status_text)
    status_thing = TwitterSession.post("statuses/update", { :status => status_text } )
    parsed = parse_json("[#{status_thing.body}]")
    parsed.first.save!
  end

  def self.get_by_twitter_user_id(user_id)
    if internet_connection?
      fetch_by_user_id!(user_id)
    else
      Status.where( twitter_user_id: user_id )
    end
  end

  def self.internet_connection?
    begin
      true if open("http://www.google.com/")
    rescue
      false
    end
  end

end

