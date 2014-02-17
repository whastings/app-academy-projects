# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)      not null
#  body       :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    tags.join(', ')
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(',').map { |tag| tag.strip.downcase }
    tag_names = tag_names.uniq
    tags = tag_names.map { |name| Tag.find_or_create_by(name: name) }
    self.tags = tags
  end
end
