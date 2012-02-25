class AddNamesToPatient < ActiveRecord::Migration
  def change
    add_column :patients, :firstname, :string
    add_column :patients, :middlename, :string
    add_column :patients, :lastname, :string
  end
end
