class AddSlugToNeighborhoods < ActiveRecord::Migration[5.1]
  def change
    add_column :neighborhoods, :slug, :string
  end
end
