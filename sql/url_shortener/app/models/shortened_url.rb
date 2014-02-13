class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  has_many(
    :visits,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "Visit"
  )

  has_many :visitors, -> { uniq }, through: :visits, source: :visitor

  has_many(
    :taggings,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "Tagging"
  )

  has_many :tag_topics, through: :taggings, source: :tag_topic

  belongs_to(
    :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: "User"
  )

  def self.random_code
    loop do
      new_short_url = SecureRandom::urlsafe_base64
      return new_short_url if self.where('short_url = ?', new_short_url).count == 0
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(
      long_url: long_url,
      submitter_id: user.id,
      short_url: random_code
    )
  end

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visits.select(:visitor_id).distinct.count
  end

  def num_recent_uniques
    self.visits.select(:visitor_id).distinct.
      where('created_at > ?', Time.now-10.minutes).count
  end

end