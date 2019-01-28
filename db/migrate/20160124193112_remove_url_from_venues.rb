class RemoveUrlFromVenues < ActiveRecord::Migration[5.1]
  def change
    remove_column :venues, :url, :string
  end
end
