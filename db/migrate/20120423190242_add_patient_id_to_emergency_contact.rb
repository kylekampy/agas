class AddPatientIdToEmergencyContact < ActiveRecord::Migration
  def change
    add_column :emergency_contacts, :patient_id, :integer
  end
end
