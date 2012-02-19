class CreateLogins < ActiveRecord::Migration
  def change
    create_table :logins do |t|
      t.string :username
      t.string :password_hash
      t.string :password_salt
      t.string :owner_type
      t.integer :owner_id

      t.timestamps
    end
  end
end
