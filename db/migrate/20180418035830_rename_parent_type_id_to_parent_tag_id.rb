class RenameParentTypeIdToParentTagId < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :tags, :parent_type_id, :parent_tag_id
  end
  def self.down
    rename_column :tags, :parent_tag_id, :parent_type_id
  end
end
