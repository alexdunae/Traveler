class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :trip, null: false
      t.string :name
      t.float :latitude
      t.float :longitude
      t.date :taken_date, default: DateTime.now
      t.text :description
      t.timestamps null: false
    end
  end
end
