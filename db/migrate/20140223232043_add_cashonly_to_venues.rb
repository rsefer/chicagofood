class AddCashonlyToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :cashonly, :boolean
  end
end
