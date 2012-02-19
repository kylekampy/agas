class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.integer :primary_phy_id
      t.date :date_of_birth
      t.integer :pharmacy_id
      t.integer :insurance_id

      t.timestamps
    end
  end
end
