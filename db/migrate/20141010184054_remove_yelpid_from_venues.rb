class RemoveYelpidFromVenues < ActiveRecord::Migration[5.1]
  def change
    remove_column :venues, :yelpid
  end
end
