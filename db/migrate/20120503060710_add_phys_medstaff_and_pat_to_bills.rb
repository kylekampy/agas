class AddPhysMedstaffAndPatToBills < ActiveRecord::Migration
  def change
    add_column :bills, :phys_id, :integer
    add_column :bills, :pat_id, :integer
    add_column :bills, :medstaff_id, :integer
  end
end
