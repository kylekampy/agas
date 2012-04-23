class AddSecondPhysicianToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :second_physician_id, :integer
  end
end
