class AddItemRatingIdToEats < ActiveRecord::Migration[5.1]
  def change
    add_reference :eats, :item_rating, index: true
  end
end
