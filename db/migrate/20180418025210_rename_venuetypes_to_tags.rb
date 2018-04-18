class RenameVenuetypesToTags < ActiveRecord::Migration[5.1]
  def self.up
    rename_table :venuetypes, :tags
  end
  def self.down
    rename_table :tags, :venuetypes
  end
end
