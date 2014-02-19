class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.references :contact, index: true
      t.string :body

      t.timestamps
    end

    add_index :comments, [:contact_id, :user_id]
  end
end
