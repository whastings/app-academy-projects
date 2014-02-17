class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author_name, null: false
      t.text :body, null: false
      t.references :article, index: true, null: false

      t.timestamps
    end
  end
end
