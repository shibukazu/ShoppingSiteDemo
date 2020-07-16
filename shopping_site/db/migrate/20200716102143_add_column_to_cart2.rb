class AddColumnToCart2 < ActiveRecord::Migration[6.0]
  def change
    add_column :carts, :status, :integer, default: 0
  end
end
