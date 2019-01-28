class AddShowmapToLists < ActiveRecord::Migration[5.1]
  def change
    add_column :lists, :showmap, :boolean, default: true
  end
end
