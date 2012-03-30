class AddPhoneToPhysician < ActiveRecord::Migration
  def change
    add_column :physicians, :phone, :string
  end
end
