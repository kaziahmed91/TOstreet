class ChangeCommentTableName < ActiveRecord::Migration
  def change
    rename_table :comments, :captures
  end
end
