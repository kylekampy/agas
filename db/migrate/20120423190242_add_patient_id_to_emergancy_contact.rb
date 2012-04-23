class AddPatientIdToEmergancyContact < ActiveRecord::Migration
  def change
    add_column :emergancy_contacts, :patient_id, :integer
  end
end
