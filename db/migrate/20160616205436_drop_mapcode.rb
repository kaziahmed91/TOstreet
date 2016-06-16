class DropMapcode < ActiveRecord::Migration
  def change
    remove_column :artworks, :mapcode
  end
end
