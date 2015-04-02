class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.date :start_date
      t.date :end_date
      t.text :description
      t.timestamps null: false
    end
  end
end
