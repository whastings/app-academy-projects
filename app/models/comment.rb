# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  author_name :string(255)      not null
#  body        :text             not null
#  article_id  :integer          not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Comment < ActiveRecord::Base
  belongs_to :article
end
