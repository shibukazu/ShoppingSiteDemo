class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.integer :user_id
      t.integer :item_id

      t.timestamps
    end
    add_index :carts, [:user_id, :item_id], unique: true
  end
end
