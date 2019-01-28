class AddOutdoorToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :outdoor, :boolean
  end
end
