class AddCodesToBill < ActiveRecord::Migration
  def change
    add_column :bills, :codes, :string
  end
end
