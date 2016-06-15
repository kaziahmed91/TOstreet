class Comments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :url, index: true
      t.string :location_id, null:false, index: true
      t.string :artist_name, index: true
      t.string :link
      t.string :text

      t.timestamps
    end
  end
end
