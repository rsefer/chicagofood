class AddOutdoorToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :outdoor, :boolean
  end
end
