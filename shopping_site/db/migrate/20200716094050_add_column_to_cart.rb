class AddColumnToCart < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :order_id, :integer
  end
end
