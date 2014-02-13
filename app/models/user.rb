class User < ActiveRecord::Base

  validates :email, presence: true, uniqueness: true

  has_many(
    :submitted_urls,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: "ShortenedUrl"
  )

  has_many(
    :visits,
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: "Visit"
    )

    has_many :visited_urls, -> { uniq }, through: :visits, source: :shortened_url
end