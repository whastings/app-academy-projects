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

  has_many :visitors, through: :visits, source: :visitor

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

end