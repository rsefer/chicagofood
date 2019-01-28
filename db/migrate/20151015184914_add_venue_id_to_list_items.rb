class AddVenueIdToListItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :list_items, :venue, index: true
  end
end
