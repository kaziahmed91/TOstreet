class Artwork < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :street1, null:false, index: true
      t.string :street2, index: true
      t.string :mapcode, null:false, index: true

      t.timestamps
    end
  end
end
