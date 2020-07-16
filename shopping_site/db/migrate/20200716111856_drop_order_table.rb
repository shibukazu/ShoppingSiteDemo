class DropOrderTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :orders
    remove_column :carts, :order_id
  end
end
