class AddPriceToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :price, :integer
  end
end
