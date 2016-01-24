class RemoveUrlFromVenues < ActiveRecord::Migration
  def change
    remove_column :venues, :url, :string
  end
end
