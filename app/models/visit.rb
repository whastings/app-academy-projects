class Visit < ActiveRecord::Base
  validates :visitor_id, presence: true
  validates :shortened_url_id, presence: true

  belongs_to(
    :visitor,
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: 'User')

  belongs_to(
    :shortened_url,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "ShortenedUrl")

  def self.record_visit!(user, shortened_url)
    self.create!(
    visitor_id: user.id,
    shortened_url_id: shortened_url.id
    )
  end

end