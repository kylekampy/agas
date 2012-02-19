class CreateHealthPrices < ActiveRecord::Migration
  def change
    create_table :health_prices do |t|
      t.string :insure_code
      t.float :cost

      t.timestamps
    end
  end
end
