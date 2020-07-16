class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :status
      t.timestamps
    end
    add_index :orders, :user_id
  end

end
