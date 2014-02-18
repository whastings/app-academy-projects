class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :screen_name, null: false
      t.string :twitter_user_id, null: false

      t.timestamps
    end
    add_index :users, :screen_name
    add_index :users, :twitter_user_id
  end

end
