class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :phy_id
      t.integer :pat_id

      t.timestamps
    end
  end
end
