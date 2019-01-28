class AddVenuetypeToListItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :list_items, :venuetype, index: true, foreign_key: true
  end
end
