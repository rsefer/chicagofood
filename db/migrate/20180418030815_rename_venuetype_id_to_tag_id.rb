class RenameVenuetypeIdToTagId < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :venues, :venuetype_id, :tag_id
  end
  def self.down
    rename_column :venues, :tag_id, :venuetype_id
  end
end
