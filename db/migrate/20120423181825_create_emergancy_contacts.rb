class CreateEmergancyContacts < ActiveRecord::Migration
  def change
    create_table :emergancy_contacts do |t|
      t.string :name

      t.timestamps
    end
  end
end
