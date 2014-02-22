class RenameColumnCommenteridInComments < ActiveRecord::Migration
  def self.up
    rename_column :comments, :commenterid, :user_id
  end

  def self.down
    rename_column :comments, :user_id, :commenterid
  end
end
