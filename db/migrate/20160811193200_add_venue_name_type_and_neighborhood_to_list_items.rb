class AddVenueNameTypeAndNeighborhoodToListItems < ActiveRecord::Migration[5.1]
  def change
    add_column :list_items, :manual_entry, :boolean, default: false
    add_column :list_items, :venue_name, :string
    add_reference :list_items, :neighborhood, index: true, foreign_key: true
  end
end
