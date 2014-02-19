class AddFavoriteToContactsAndContactShares < ActiveRecord::Migration
  def change
    add_column :contacts, :favorite, :boolean, default: false
    add_column :contact_shares, :favorite, :boolean, default: false

    add_index :contacts, :favorite
    add_index :contact_shares, :favorite
  end
end
