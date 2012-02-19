class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email_type
      t.string :email
      t.string :owner_type
      t.integer :owner_id

      t.timestamps
    end
  end
end
