class AddByobToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :byob, :boolean
  end
end
