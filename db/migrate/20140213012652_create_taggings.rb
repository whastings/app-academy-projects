class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :shortened_url_id
      t.integer :tag_topic_id
    end
    add_index :taggings, :shortened_url_id
    add_index :taggings, :tag_topic_id
  end
end
