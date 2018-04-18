class ConvertTagIdToString < ActiveRecord::Migration[5.1]
  def self.up
    change_column :venues, :tag_id, :string
  end
  def self.down
    change_column :venues, :tag_id, :integer
  end
end
