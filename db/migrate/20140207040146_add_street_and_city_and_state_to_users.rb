class AddStreetAndCityAndStateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :street, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
  end
end
