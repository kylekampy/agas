class AddGenderToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :gender, :string
  end
end
