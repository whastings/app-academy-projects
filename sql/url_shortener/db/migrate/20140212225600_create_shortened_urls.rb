class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, limit: 1000, null: false
      t.string :short_url, null: false
      t.integer :submitter_id, null: false
    end
    add_index :shortened_urls, :short_url, unique: true
    add_index :shortened_urls, :submitter_id
  end
end
