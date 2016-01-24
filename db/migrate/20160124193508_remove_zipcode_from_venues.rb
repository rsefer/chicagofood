class RemoveZipcodeFromVenues < ActiveRecord::Migration
  def change
    remove_column :venues, :zipcode, :string
  end
end
