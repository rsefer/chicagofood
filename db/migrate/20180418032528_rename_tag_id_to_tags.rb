class RenameTagIdToTags < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :venues, :tag_id, :tags
  end
  def self.down
    rename_column :venues, :tags, :tag_id
  end
end
