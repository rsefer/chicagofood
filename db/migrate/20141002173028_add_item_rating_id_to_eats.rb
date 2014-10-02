class AddItemRatingIdToEats < ActiveRecord::Migration
  def change
    add_reference :eats, :item_rating, index: true
  end
end
