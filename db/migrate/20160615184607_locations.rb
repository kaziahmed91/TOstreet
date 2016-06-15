class Locations < ActiveRecord::Migration
  def change
    create_table :artworks do |t|
      t.string :location_id, null:false, index: true
      t.datetime :created_at, null:false
      t.datetime :updated_at

      t.timestamps
    end
  end
end
