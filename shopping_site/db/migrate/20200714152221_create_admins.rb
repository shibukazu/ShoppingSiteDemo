class CreateAdmins < ActiveRecord::Migration[6.0]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :password_digest
      t.boolean :master, default: false

      t.timestamps
    end
  end
end
