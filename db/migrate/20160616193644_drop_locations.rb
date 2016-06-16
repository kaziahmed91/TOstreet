class DropLocations < ActiveRecord::Migration
  def change
    drop_table :artworks
    rename_table :locations, :artworks
  end
end
