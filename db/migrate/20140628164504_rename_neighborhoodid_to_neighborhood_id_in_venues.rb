class RenameNeighborhoodidToNeighborhoodIdInVenues < ActiveRecord::Migration[5.1]
  def change
    rename_column :venues, :neighborhoodid, :neighborhood_id
    rename_column :venues, :typeid, :type_id
    rename_column :venuetypes, :parenttypeid, :parent_type_id
    rename_column :neighborhoods, :parentneighborhoodid, :parent_neighborhood_id
  end
end
