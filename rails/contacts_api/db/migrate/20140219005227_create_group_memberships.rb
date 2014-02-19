class CreateGroupMemberships < ActiveRecord::Migration
  def change
    create_table :group_memberships do |t|
      t.references :group, index: true
      t.references :contact, index: true

      t.timestamps
    end

    add_index :group_memberships, [:contact_id, :group_id], unique: true
  end
end
