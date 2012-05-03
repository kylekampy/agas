class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :id
      t.string :unique_hash
      t.string :status
      t.float :price
      t.float :insurance_coverage

      t.timestamps
    end
  end
end
