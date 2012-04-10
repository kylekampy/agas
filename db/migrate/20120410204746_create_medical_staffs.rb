class CreateMedicalStaffs < ActiveRecord::Migration
  def change
    create_table :medical_staffs do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.integer :doc_id

      t.timestamps
    end
  end
end
