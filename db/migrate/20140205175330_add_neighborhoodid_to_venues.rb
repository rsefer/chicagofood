class AddNeighborhoodidToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :neighborhoodid, :integer
  end
end
