class ChangeColumnOfOrder < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :status, :integer, default: 0
  end
end
