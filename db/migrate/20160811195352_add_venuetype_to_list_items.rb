class AddVenuetypeToListItems < ActiveRecord::Migration
  def change
    add_reference :list_items, :venuetype, index: true, foreign_key: true
  end
end
