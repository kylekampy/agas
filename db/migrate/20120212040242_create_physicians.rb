class CreatePhysicians < ActiveRecord::Migration
  def change
    create_table :physicians do |t|
      t.string :specialty
      t.string :office_num
      t.timestamps
    end
  end
end
