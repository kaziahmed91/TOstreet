class Tables1 < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, index: true
      t.string :password_digest, null: false
      t.string :login_token, index: true
      t.string :remember_token, index: true

      t.timestamps
    end
  end
end
