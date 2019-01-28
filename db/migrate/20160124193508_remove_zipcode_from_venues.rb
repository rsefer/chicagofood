class RemoveZipcodeFromVenues < ActiveRecord::Migration[5.1]
  def change
    remove_column :venues, :zipcode, :string
  end
end
