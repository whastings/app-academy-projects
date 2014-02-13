class Tagging < ActiveRecord::Base

  validates :shortened_url_id, presence: true
  validates :tag_topic_id, presence: true

  belongs_to(
    :tag_topic,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: "TagTopic"
  )

  belongs_to(
    :shortened_url,
    primary_key: :id,
    foreign_key: :shortened_url_id,
    class_name: "ShortenedUrl"
  )

end