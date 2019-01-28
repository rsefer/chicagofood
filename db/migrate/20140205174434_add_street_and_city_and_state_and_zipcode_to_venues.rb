class AddStreetAndCityAndStateAndZipcodeToVenues < ActiveRecord::Migration[5.1]
  def change
    add_column :venues, :street, :string
    add_column :venues, :city, :string
    add_column :venues, :state, :string
    add_column :venues, :zipcode, :string
  end
end
