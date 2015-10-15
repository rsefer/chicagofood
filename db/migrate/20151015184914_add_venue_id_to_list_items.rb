class AddVenueIdToListItems < ActiveRecord::Migration
  def change
    add_reference :list_items, :venue, index: true
  end
end
