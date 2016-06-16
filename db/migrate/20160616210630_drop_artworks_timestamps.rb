class DropArtworksTimestamps < ActiveRecord::Migration
  def change
    remove_column :artworks, :created_at
    remove_column :artworks, :updated_at
  end
end
