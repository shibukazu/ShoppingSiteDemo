class CreateOrderPairs < ActiveRecord::Migration[6.0]
  def change
    create_table :order_pairs do |t|
      t.integer :order_id
      t.integer :item_id
      t.timestamps
    end
    add_index :order_pairs, :order_id
  end
end
