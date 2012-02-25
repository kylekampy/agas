class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :zip
      t.string :street
      t.string :state
      t.string :country
      t.string :owner_type
      t.integer :owner_id

      t.timestamps
    end
  end
end
