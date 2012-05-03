class AddDateAndTimeToBills < ActiveRecord::Migration
  def change
    add_column :bills, :date, :date
    add_column :bills, :time, :time
  end
end
