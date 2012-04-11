class AddPhoneToMedicalStaff < ActiveRecord::Migration
  def change
    add_column :medical_staffs, :phone, :string
  end
end
