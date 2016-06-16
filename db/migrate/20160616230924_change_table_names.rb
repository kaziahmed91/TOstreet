class ChangeTableNames < ActiveRecord::Migration
  def change
    rename_table :artworks, :intersections
    rename_table :captures, :posts
  end
end
