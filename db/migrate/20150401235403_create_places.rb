class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.references :trip, null: false
      t.string :name, null: false
      t.boolean :visited, default: false
      t.date :visited_date
      t.string :description
      t.double :latitude, null: false
      t.double :longitude, null: false
      t.timestamps null: false
    end
  end
end
