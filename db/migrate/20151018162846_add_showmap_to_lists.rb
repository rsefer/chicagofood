class AddShowmapToLists < ActiveRecord::Migration
  def change
    add_column :lists, :showmap, :boolean, default: true
  end
end
