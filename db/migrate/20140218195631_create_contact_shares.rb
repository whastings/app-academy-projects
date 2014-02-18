class CreateContactShares < ActiveRecord::Migration
  def change
    create_table :contact_shares do |t|
      t.references :contact, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end

    add_index(:contact_shares, [:contact_id, :user_id], unique: true)
  end
end
