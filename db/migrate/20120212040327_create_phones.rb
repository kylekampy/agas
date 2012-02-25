class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone_type
      t.string :phone
      t.string :owner_type
      t.integer :owner_id

      t.timestamps
    end
  end
end
