class AddNeighborhoodidToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :neighborhoodid, :integer
  end
end
