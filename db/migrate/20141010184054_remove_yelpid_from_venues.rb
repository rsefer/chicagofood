class RemoveYelpidFromVenues < ActiveRecord::Migration
  def change
    remove_column :venues, :yelpid
  end
end
