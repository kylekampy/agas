class AddPaymentToBills < ActiveRecord::Migration
  def change
    add_column :bills, :payment, :float
  end
end
