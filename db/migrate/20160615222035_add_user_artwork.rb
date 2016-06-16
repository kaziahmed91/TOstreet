class AddUserArtwork < ActiveRecord::Migration
  def change
    rename_column :comments, :location_id, :artwork_id
    add_column :comments, :user_id, :integer
  end
end
