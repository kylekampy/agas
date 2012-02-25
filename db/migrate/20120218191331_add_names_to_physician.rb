class AddNamesToPhysician < ActiveRecord::Migration
  def change
    add_column :physicians, :firstname, :string
    add_column :physicians, :middlename, :string
    add_column :physicians, :lastname, :string
  end
end
