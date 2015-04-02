class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :place, null: false
      t.double :latitude
      t.double :longitude
      t.date :taken_date, default: Date.now
      t.text :description
      t.timestamps null: false
    end
  end
end
