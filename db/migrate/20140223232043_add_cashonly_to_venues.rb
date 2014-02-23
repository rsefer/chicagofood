class AddCashonlyToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :cashonly, :boolean
  end
end
